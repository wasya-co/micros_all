
require 'httparty'
require 'json'

require_relative './demmitv/sitemap'
require_relative './ish/sitemap'
require_relative './pi/sitemap'
require_relative './wco/sitemap'

def puts! args, label=""
  puts "+++ +++ #{label}"
  puts args.inspect
end

##
## curl https://piousbox.com/index.php?p=2399 -I -H 'Cache-Control: no-cache, no-store'
##

NAMESPACES = %w| Demmitv Ish Wco Pi |

namespace :sitemap do

  desc 'be rake sitemap:export namespace=Demmitv|Ish|Pi|Wco [ origin="https://wasyaco.com" ] '
  task :export => :environment do

    if !ENV['namespace']
      puts "Usage: "
      puts 'be rake sitemap:export namespace=Demmitv|Ish|Pi|Wco [ origin="https://wasyaco.com" ] '
      exit
    end

    if !NAMESPACES.include?( ENV['namespace'] )
      puts "Available namespaces: "
      puts NAMESPACES
      exit
    end

    origin = ENV['origin'] || "#{ENV['namespace']}::Sitemap".constantize::DEFAULT_ORIGIN

    out = "#{ENV['namespace']}::Sitemap".constantize.new.checks.select do |item|
      item[:selector].present? && !item[:private]
    end
    out.each do |check|
      puts "#{origin}#{check[:path]}"
    end

  end

  task resave: :environment do
    Wco::SitemapPath.unscoped.map &:destroy!
    site = Wco::Site.find '661fe7f1767ccd74d5a0f534'
    "Wco::Sitemap".constantize.new.checks.each do |check|
      spath = Wco::SitemapPath.new({
        site_id: site.id,
        path: check[:path],
        redirect_to: check[:redirect_to],
        selector: check[:selector],
        selectors: check[:selectors],
      })
      if spath.save
        print '^'
      else
        puts spath.errors.full_messages
      end
    end
    puts 'ok'
  end

  desc 'be rake sitemap:check namespace=Demmitv|Ish|Pi|Wco [ origin="http://wco_local:8088" ] '
  task :check => :environment do

    if !ENV['namespace']
      puts "Usage: "
      puts 'be rake sitemap:test namespace=Demmitv|Ish|Pi|Wco [ origin="https://wasyaco.com" ] '
      exit
    end

    if !NAMESPACES.include?( ENV['namespace'] )
      puts "Available namespaces: "
      puts NAMESPACES
      exit
    end

    results = []
    total_count = 0
    error_count = 0

    origin = ENV['origin'] || "#{ENV['namespace']}::Sitemap".constantize::DEFAULT_ORIGIN

    "#{ENV['namespace']}::Sitemap".constantize.new.checks.each do |check|
      total_count += 1

      # puts "Checking #{check[:path]}:"
      if check[:selector]
        begin
          body = HTTParty.get( "#{origin}#{check[:path]}" ).body
        rescue OpenSSL::SSL::SSLError => err
          results.push "NOT OK [ssl-exception] #{check[:path]}".red
          next
        end
        doc = Nokogiri::HTML( body )
        out = doc.search check[:selector]
        if out.present?
          results.push "OK #{check[:path]}"
        else
          results.push "NOT OK [selector-missing] #{check[:path]}".red
          error_count += 1
        end

        if check[:meta_description]
          out = doc.search( 'head meta[name="description"]' )[0]['content']
          if check[:meta_description] == out
            results.push "OK #{check[:path]} meta_description"
          else
            results.push "NOT OK [meta-description-missing] #{check[:path]}".red
            error_count += 1
          end
        end

      elsif check[:redirect_to]
        out = HTTParty.get( "#{origin}#{check[:path]}", follow_redirects: false )
        if( out.headers[:location] == check[:redirect_to] ||
            out.headers[:location] == "#{origin}#{check[:redirect_to]}" )
          results.push "OK #{check[:path]}"
        else
          results.push "NOT OK [redirect-missing] #{check[:path]}".red

          puts!( out.response, 'response' ) if DEBUG
          # puts!( out.body, 'body' ) if DEBUG

          error_count += 1

          puts "NOT OK #{check[:path]}".red
          puts out.headers[:location]
          puts check[:redirect_to]
        end
      else
        results.push "SKIP #{check[:path]}"
      end

      if check[:selectors]
        check[:selectors].each do |selector|
          body = HTTParty.get( "#{origin}#{check[:path]}" ).body
          doc = Nokogiri::HTML( body )
          out = doc.search selector
          if out.present?
            results.push "OK #{check[:path]} selectors:#{selector}"
          else
            results.push "NOT OK [selectors-missing:#{selector}] #{check[:path]}".red
            error_count += 1
          end
        end
      end

    end

    puts "Results:".green
    results.each do |r|
      puts r
    end
    puts "Total count: #{total_count}"
    puts "Error count: #{error_count}"
  end

end


