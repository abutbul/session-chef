#
# Cookbook Name:: my-first-cookbook
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#
cookbook_file '/tmp/david.txt' do
  source 'mkfile/just-text.txt'
  action :create
  owner 'root'
end


