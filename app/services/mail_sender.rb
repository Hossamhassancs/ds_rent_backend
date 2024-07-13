require 'sendgrid-ruby'
include SendGrid

class MailSender

  def self.send(customer_name, email, phone, time, car_id)
    from = Email.new(email: 'maraghy@milia.com.sa')
    to = Email.new(email: 'maraghy@milia.com.sa')
    subject = "test drive Request From #{email}"
    car = Car.find(car_id)
    content = Content.new(type: 'text/plain', value: "test drive Request From client #{customer_name} with #{email} and phone #{phone} on time: #{time} and requested to test car #{car.name_en}")
    mail = Mail.new(from, subject, to, content)

    recipients = [
      Email.new(email: 'sultan@smartcar.com.sa'),
      Email.new(email: 'Info@smartcar.com.sa'),
      Email.new(email: 'maraghy@milia.com.sa')
    ]

    recipients.each do |recipient|
      mail.personalizations[0].add_to(recipient)
    end

    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])

    response = sg.client.mail._('send').post(request_body: mail.to_json)
  end  
end