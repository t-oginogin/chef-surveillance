#
# Cookbook Name:: lib_for_ruby
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

node['lib_for_ruby']['packages'].each do |package_name|
  package "#{package_name}" do
    :install
  end
end
