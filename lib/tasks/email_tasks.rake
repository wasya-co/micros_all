
namespace :email do

  ## Not used until I revisit it. _vp_ 2023-04-02
  desc 'email:churn_mbox mbox_path=<filepath> '
  task churn_mbox: :environment do

    ## Usage
    if !ENV['mbox_path']
      puts ""
      puts "Usage: email:churn_mbox mbox_path=<filepath> "
      puts ""
      exit 22
    end

    which_file = ENV['mbox_path']
    message    = nil

    # Tag
    tag_names = [
      File.basename( ENV['mbox_path'], '.*' ),
      "20230302-import",
    ]
    term_ids = tag_names.map do |tag_name|
      tag = WpTag.where( name: tag_name ).first
      tag ||= WpTag.my_create( name: tag_name, taxonomy: 'email_tag' )
      tag.id
    end

    client = Aws::S3::Client.new({
      region:            ::S3_CREDENTIALS[:region],
      access_key_id:     ::S3_CREDENTIALS[:access_key_id],
      secret_access_key: ::S3_CREDENTIALS[:secret_access_key] })


    File.readlines( which_file, encoding: "ISO8859-1" ).each do |line|
      if (line.match(/\AFrom /))

        ## @TODO: remove copy-paste [ref-1]
        if message
          the_mail       = Mail.new(message)
          filename       = the_mail.date.in_time_zone.to_s[0..18].gsub(' ', 'T').gsub(':', '_')
          filename       = "#{filename}F#{the_mail.from[0].sub('@', '_').gsub('.', '_')}"
          flag = client.put_object({ bucket: ::S3_CREDENTIALS[:bucket_ses],
            key: filename,
            body: message,
          })
          @stub = ::Office::EmailMessageStub.create({
            object_key: filename,
            object_path: "https://#{::S3_CREDENTIALS[:bucket_ses]}.s3.amazonaws.com/#{filename}",
            state: ::Office::EmailMessageStub::STATE_PENDING,
            term_ids: term_ids,
          })
          if @stub.persisted?
            Ishapi::EmailMessageIntakeJob.perform_later( @stub.id.to_s )
          else
            puts! @stub.errors.full.messages.join(", "), "111 Cannot save this stub: #{@stub.id}."
          end
          print '.'
        end
        message = ''

      else
        message << line.sub(/^\>From/, 'From')
      end
    end

    ## @TODO: remove copy-paste [ref-1]
    if message
      the_mail       = Mail.new(message)
      filename       = the_mail.date.in_time_zone.to_s[0..18].gsub(' ', 'T').gsub(':', '_')
      filename       = "#{filename}F#{the_mail.from[0].sub('@', '_').gsub('.', '_')}"
      flag = client.put_object( bucket: ::S3_CREDENTIALS[:bucket_ses],
        key: filename,
        body: message )
      @stub = ::Office::EmailMessageStub.create({
        object_key: filename,
        object_path: "https://#{::S3_CREDENTIALS[:bucket_ses]}.s3.amazonaws.com/#{filename}",
        state: ::Office::EmailMessageStub::STATE_PENDING,
        term_ids: term_ids,
      })
      if @stub.persisted?
        Ishapi::EmailMessageIntakeJob.perform_later( @stub.id.to_s )
      else
        puts! @stub.errors.full.messages.join(", "), "222 Cannot save this stub: #{@stub.id}."
      end
      print '.'
    end
    message = ''

    puts "ok"
  end

  ## Not used until I revisit it. _vp_ 2023-04-02
  desc 'after lambda puts object_key in mdb'
  task churn_messages: :environment do
    Office::EmailMessageStub.pending.each do |msg|
      Ishapi::EmailMessageIntakeJob.process_later( msg.id )
    end
  end

  desc 'be rake email:churn_one key_id=0ijbh58ocnat5oal6iqchn4rosj9q99u3opq37o1'
  task churn_one: :environment do
    object_key = ENV['key_id'] || 'iao4kfrcot6d3pd3hqp9af21e28iev6b5eoi6781'
    stub = MsgStub.find_or_create_by({ object_key: object_key }).update({ state: 'state_pending' })
    stub = MsgStub.find_by({ object_key: object_key })
    EIJ.new.perform( stub.id )
  end

  desc '2023-09-23 test 2'
  task :churn_leads_20230923 => :environment do
    Office::EmailConversation.all.each do |conv|
      conv.lead_ids.each do |lead_id|
        Office::EmailConversationLead.find_or_create_by({
          email_conversation_id: conv.id,
          lead_id: lead_id,
        })
        print '.'
      end
      puts '^'
    end
  end

end


