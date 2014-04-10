#
# Cookbook Name:: distelli_agent
# Recipe:: default
#
# Copyright 2014, Distelli Inc.
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

remote_file "/tmp/#{node[:distelli][:agent][:package]}" do
  source "#{node[:distelli][:agent][:url]}#{node[:distelli][:agent][:package]}"
  mode 00644
end

bash "install_agent" do
  user "root"
  group "root"
  cwd "/tmp"
  code <<-EOH
  tar -C /usr/local/DistelliAgent/ -zxvf /tmp/#{node[:distelli][:agent][:package]} >> /usr/local/DistelliAgent/logs/install.log 2>&1
  ln -sf /usr/local/DistelliAgent/bin/dagent /usr/local/bin/ >> /usr/local/DistelliAgent/logs/install.log 2>&1  
  EOH
end

group node[:distelli][:agent][:group] do
  action :create
end

user node[:distelli][:agent][:user] do
  gid node[:distelli][:agent][:group]
  supports :manage_home => true
  comment "Distelli User"
  home "/home/#{node[:distelli][:agent][:user]}"
  shell "/bin/bash"
end

directory "/distelli" do
  owner "distelli"
  group "distelli"
  mode 00777
  action :create
end

template "/etc/distelli.yml" do
  source "distelli.yml.erb"
  mode 00644
end

execute "dagent" do
  command "dagent start #{node[:fqdn]}"
  cwd "/home/#{node[:distelli][:agent][:user]}"
  user node[:distelli][:agent][:user]
  group node[:distelli][:agent][:group]
end
