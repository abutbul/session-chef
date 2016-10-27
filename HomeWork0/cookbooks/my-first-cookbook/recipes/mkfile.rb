#
# Cookbook Name:: my-first-cookbook
# Recipe:: mkfile
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#

directory '/opt/opsSchool' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end
cookbook_file '/opt/opsSchool/david.txt' do
  source 'mkfile/just-text.txt'
  action :create
  owner 'root'
end


