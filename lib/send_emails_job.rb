SendEmailsJob = Struct.new(:order) do
  def perform
    users = User.all
    users.each do |user|
      if user.roles.where(name: ["Super Admin", "Admin"]).any?
        UserMailer.notification(user,order).deliver
      end
    end
  end

  def max_attempts
    2
  end
end
