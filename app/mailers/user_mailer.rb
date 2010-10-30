class UserMailer < ActionMailer::Base
  default :from => "no-reply@#{host}"

  def forgot_password(user, key)
    set_variables(user, key)
    mail( :subject => "#{app_name} -- forgotten password",
          :to      => user.email_address )
  end

private

  def set_variables(user, key)
    @user = user
    @key = key
  end

end
