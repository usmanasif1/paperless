roles = [{name: 'Super Admin'}, {name: 'Admin'}, {name: 'User'}]
roles.each do |role|
	Role.create!(name: role[:name])
end

# user = User.create!({
#  :username=>"admin",
#  :email=>"admin@paperless.com",
#  :password=>"admin123",
#  :password_confirmation=>"admin123",
# })

# role = user.user_roles.build
# role.role_id = Role.find_by_name('Super Admin').id
# role.save!

user = User.create!({
   :username=>"Faisal",
   :email=>"faisal.bhatti@devsinc.com",
   :password=>"admin123",
   :password_confirmation=>"admin123",
})

role = user.user_roles.build
role.role_id = Role.find_by_name('Admin').id
role.save!

user = User.create!({
   :username=>"Usman Asif",
   :email=>"usman.asif@devsinc.com",
   :password=>"admin123",
   :password_confirmation=>"admin123",
})

role = user.user_roles.build
role.role_id = Role.find_by_name('Admin').id
role.save!