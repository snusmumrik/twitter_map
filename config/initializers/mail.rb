require "smtp_tls"

# 
# pop & imap settings
# 
module CelebLog
  USE_APOP = false
  # for DNS health check
  POP_SERVER = {
    :address => 'mail.MyDNS.JP',
    :port => 995,
    :account => 'mydns28275',
    :password => 'vH3Dsty4'
    }
  IMAP_SERVER = {
    :address => 'imap.gmail.com',
    :port => 993,
    :account => 'example@example.com',
    :password => 'password'
    }
end

# 
# smtp settings
#
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :address => "smtp.gmail.com",
  :port => 587,
  :domain => "example.com",
  :authentication => :plain,
  :user_name => "example@example.com",
  :password => "password"
}