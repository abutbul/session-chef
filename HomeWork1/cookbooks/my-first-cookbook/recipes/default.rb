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
    options '--force-yes'
  end
end
execute 'Install python package' do
  command 'pip install flask '
  action :run
	not_if { File.exist?("/usr/local/lib/python2.7/dist-packages/flask") }
end

cookbook_file node['mycookbook']['app']['db_creation_script'] do
  action :create
  owner 'root'
  group 'root'
  notifies :run, 'execute[CREATE USER]', :immediate
  notifies :run, 'execute[makeAARdb]', :immediate
end

execute 'makeAARdb' do
  action :nothing
  command "mysql -p#{node['mycookbook']['app']['mysql_pass']} < #{node['mycookbook']['app']['db_creation_script']}"
  not_if "mysql -p#{node['mycookbook']['app']['mysql_pass']} -e 'show databases;'|grep #{node['mycookbook']['app']['db_name']}"
end

execute 'CREATE USER' do
  action :nothing
  command "mysql -p#{node['mycookbook']['app']['mysql_pass']} -e \"GRANT ALL PRIVILEGES ON #{node['mycookbook']['app']['db_name']}.* TO '#{node['mycookbook']['app']['db_user']}'@#{node['mycookbook']['app']['db_host']} IDENTIFIED BY '#{node['mycookbook']['app']['db_pass']}';\""
  not_if "mysql -p#{node['mycookbook']['app']['mysql_pass']} -e 'select user from mysql.user;'|grep #{node['mycookbook']['app']['db_name']}"
end

template node['mycookbook']['apache']['conf_file'] do
  source 'AAR-apache.conf.erb'
  owner node['mycookbook']['apache']['user']
  group node['mycookbook']['apache']['group'] 
  action :create
  notifies :restart, 'service[apache2]', :immediately
end

service 'apache2' do
  action [:start, :enable]
end
template node['mycookbook']['app']['config_file'] do
  source 'AAR_config.py.erb'
  action :create
end

