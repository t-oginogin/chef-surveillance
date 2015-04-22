#
# Cookbook Name:: mysql
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

install_dir = '/usr/local/src'

mysql_user = node['mysql']['user']
mysql_version = node['mysql']['version']
mysql_password = node['mysql']['password']

package "mysql-server-#{mysql_version}" do
  action :install
end

template '/etc/mysql/my.cnf' do
  source 'my.cnf.erb'
  owner "#{mysql_user}"
  group "#{mysql_user}"
  mode 644

  variables ({
    :character_set_server => node['mysql']['character_set_server'],
  })
end

service 'mysql' do
  action [:start, :enable]
end

bash "secure_install" do
  user "#{mysql_user}"
  not_if "mysql -u #{mysql_user} -p#{mysql_password} -e 'show databases;'"

  code <<-EOL
    mysql -u #{mysql_user} -e "DELETE FROM user WHERE user = '';"
    mysql -u #{mysql_user} -e "DELETE FROM user WHERE user='#{mysql_user}' AND host NOT IN ('localhost', '127.0.0.1', '::1');"
    mysql -u #{mysql_user} -e "SET PASSWORD FOR '#{mysql_user}'@'::1' = PASSWORD('#{mysql_password}');"
    mysql -u #{mysql_user} -e "SET PASSWORD FOR '#{mysql_user}'@'127.0.0.1' = PASSWORD('#{mysql_password}');"
    mysql -u #{mysql_user} -e "SET PASSWORD FOR '#{mysql_user}'@'localhost' = PASSWORD('#{mysql_password}');"
    mysql -u #{mysql_user} -p#{mysql_password} -e "flush privileges;"
  EOL
end
