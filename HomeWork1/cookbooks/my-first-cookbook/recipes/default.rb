#
# Cookbook Name:: my-first-cookbook
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
node['mycookbook']['packages'].each do |pkg|
  package pkg do
    action :install
	not_if "dpkg -l | grep #{pkg} | grep ii" 
  end
end
execute 'Install python package' do
  command 'pip install flask '
  action :run
	not_if { File.exist?("/usr/local/lib/python2.7/dist-packages/flask") }
end

