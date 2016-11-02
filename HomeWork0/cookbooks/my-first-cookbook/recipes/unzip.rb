#
# Cookbook Name:: my-first-cookbook
# Recipe:: unzip
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#
package "unzip" do
  version '6.0-9ubuntu1.5'
  action :install
end

template '/opt/opsSchool/david.txt' do
  source 'installed.erb'
  owner 'root'
  group 'root'
  variables({
    :packageinstalled => 'unzip',
    :packageinstalled_ver => '6.0-9'
  })
end

