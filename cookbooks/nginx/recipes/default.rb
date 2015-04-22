#
# Cookbook Name:: nginx
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package 'nginx' do
  action :install
end

bash 'delete default' do
  user 'root'
  not_if { !(File.exists? '/etc/nginx/sites-enabled/default') }
  code <<-EOL
    rm /etc/nginx/sites-enabled/default
  EOL
end

bash 'delete share' do
  user 'root'
  not_if { !(File.exists? '/usr/share/nginx') }
  code <<-EOL
    rm -rf /usr/share/nginx
  EOL
end

service 'nginx' do
  action [:start, :enable]
end
