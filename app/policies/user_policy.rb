class UserPolicy
  attr_reader :current_user, :record

  def initialize(current_user, record)
    @current_user = current_user
    @user = record
  end

  def index?
    @current_user.roles.where(name: ["Super Admin", "Admin"]).any?
  end

  def update?
    @current_user.roles.where(name: ["Super Admin", "Admin"]).any?
  end

  def destroy?
    @current_user.roles.where(name: ["Super Admin", "Admin"]).any?
  end
end

