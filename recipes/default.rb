#
# Cookbook Name:: distelli_agent_install
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
directory "/usr/local/DistelliAgent/" do
  owner "root"
  group "root"
  mode 00755
  action :create
end

directory "/usr/local/DistelliAgent/logs" do
  owner "root"
  group "root"
  mode 00755
  action :create
end

remote_file "/tmp/DistelliAgent-1.73.tar.gz" do
  source "http://www.distelli.com/downloads/DistelliAgent-1.73.tar.gz"
  mode 00644
end

bash "install_agent" do
  user "root"
  group "root"
  cwd "/tmp"
  code <<-EOH
  tar -C /usr/local/DistelliAgent/ -zxvf /tmp/DistelliAgent-1.73.tar.gz >> /usr/local/DistelliAgent/logs/install.log 2>&1
  ln -sf /usr/local/DistelliAgent/bin/dagent /usr/local/bin/ >> /usr/local/DistelliAgent/logs/install.log 2>&1  
  EOH
end

user "distelli" do
  supports :manage_home => true
  comment "Distelli User"
  home "/home/distelli"
  shell "/bin/bash"
end

directory "/distelli" do
  owner "distelli"
  group "distelli"
  mode 00777
  action :create
end

cookbook_file "/etc/distelli.yml" do
  source "distelli.yml"
  mode 00644
end

execute "dagent" do
  command "dagent start #{node[:cloud][:public_hostname]}"
  cwd "/home/distelli"
  user "distelli"
  group "distelli"
end
