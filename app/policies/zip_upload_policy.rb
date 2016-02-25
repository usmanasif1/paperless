class ZipUploadPolicy
  attr_reader :current_user, :record

  def initialize(current_user, record)
    @current_user = current_user
    @user = record
  end

  def new?
    @current_user.roles.where(name: ["Super Admin", "Admin"]).any?
  end
end

