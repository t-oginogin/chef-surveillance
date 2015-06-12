#
# Cookbook Name:: font
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#


node['font']['packages'].each do |package_name|
  package "#{package_name}" do
    :install
  end
end
