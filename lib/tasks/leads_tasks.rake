
namespace :leads do

  desc "20221118 - churn to leadsets"
  task :to_leadsets => :environment do
    puts "Churning #{Lead.where( email: nil ).length} leads."
    Lead.where( email: nil ).each do |lead|
      leadset = Leadset.new( name: lead.company_name,
        company_url: lead.company_url,
        comment: lead.comment,
        location: lead.location )
      flag = leadset.save
      if flag
        print '.'
        lead.destroy
      else
        puts! leadset.errors.full_messages.join(', ')
      end
    end
    puts 'ok'
  end

end



