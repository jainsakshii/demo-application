# Preview all emails at http://localhost:3000/rails/mailers/booking_mail_mailer
class BookingMailMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/booking_mail_mailer/create_mail_to_user
  def create_mail_to_user
    BookingMailMailer.create_mail_to_user
  end

end
