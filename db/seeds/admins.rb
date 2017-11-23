Admin.find_or_create_by!(username: 'admin') do |admin|
  admin.password = 'test1234'
end
