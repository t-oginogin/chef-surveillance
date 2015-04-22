#
# Cookbook Name:: timezone
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

bash 'set timezone' do
  not_if 'date | grep JST'
  code <<-EOL
    sudo echo Asia/Tokyo > /etc/timezone
    sudo dpkg-reconfigure --frontend noninteractive tzdata
  EOL
end
