class UserMailer < ApplicationMailer
    default from: "notifications@nobe.com"

    def welcome_email(user)
        @user = user
        mail(to: @user.email, subject: "Bem-vindo(a) à Nobe Sistemas")
    end
end
