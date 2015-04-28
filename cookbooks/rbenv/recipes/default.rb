#
# Cookbook Name:: rbenv
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

rbenv_user = node['rbenv']['user']
ruby_version = node['rbenv']['ruby_version']

bash 'install rbenv' do
  user "#{rbenv_user}"
  not_if 'test -e ~/.rbenv'
  code <<-EOL
    git clone https://github.com/sstephenson/rbenv.git $HOME/.rbenv
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> $HOME/.bash_profile
    echo 'eval "$(rbenv init -)"' >> $HOME/.bash_profile
    chown #{rbenv_user} $HOME/.bash_profile
    chgrp #{rbenv_user} $HOME/.bash_profile
    source $HOME/.bash_profile
  EOL
end

bash 'install ruby-build' do
  user "#{rbenv_user}"
  not_if 'test -e ~/.rbenv/plugins/ruby-build'
  code <<-EOL
    source $HOME/.bash_profile
    git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build 
  EOL
end

bash 'install ruby' do
  user "#{rbenv_user}"
  code <<-EOL
    source $HOME/.bash_profile
    rbenv install #{ruby_version}
    rbenv global #{ruby_version}
    rbenv rehash
    sudo chown -R #{rbenv_user}:#{rbenv_user} $HOME/.rbenv
  EOL
end

bash 'install bundler and rails' do
  user "#{rbenv_user}"
  code <<-EOL
    source $HOME/.bash_profile
    rbenv global #{ruby_version}
    gem install bundler --no-ri --no-rdoc
    gem install rails --no-ri --no-rdoc
    rbenv rehash
  EOL
end
