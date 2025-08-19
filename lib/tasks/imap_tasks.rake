
namespace :imap do

  desc 'check email'
  task check_inbox: :environment do

    imap = Net::IMAP.new('mail.infiniteshelter.com', ssl: false)
    # imap.port          => 993
    # imap.tls_verified? => true
    case imap.greeting.name
    in /OK/i
      # The client is connected in the "Not Authenticated" state.
      imap.authenticate("PLAIN", ENV['IMAP_USER'], ENV['IMAP_PASSWD'])
    in /PREAUTH/i
      # The client is connected in the "Authenticated" state.

    end # end

    # byebug

    puts! imap.list('*', '*')
    puts! imap.examine('INBOX')

    imap.list("", "*").map(&:name).each do |mailbox|
      imap.examine(mailbox)

      uids = imap.uid_search(["ALL"])
      uids.each_with_index do |uid, i|
        raw_email = imap.uid_fetch(uid, "RFC822").first.attr["RFC822"]
        email = Mail.new(raw_email)

        puts! email.subject, 'ze email subj'
      end
    end

  end
end
