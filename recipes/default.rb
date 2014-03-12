#
# Cookbook Name:: lamp
# Recipe:: default
#
# Copyright (C) 2014 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'apt'
include_recipe 'php'
include_recipe 'apache2'
include_recipe 'apache2::mod_php5'
include_recipe 'mysql'
include_recipe 'mysql::server'
include_recipe "database::mysql"

db_name = node[:lamp][:mysql][:db_name]

mysql_connection_info = {
  :host     => 'localhost',
  :username => 'root',
  :password => node['mysql']['server_root_password']
}

mysql_database db_name do
  connection mysql_connection_info
  action :create
end

mysql_database_user node[:lamp][:mysql][:user] do
  connection    mysql_connection_info
  password      node[:lamp][:mysql][:password]
  database_name db_name
  host          '%'
  privileges    [:all]
  action        :grant
end

mysql_database_user node[:lamp][:mysql][:user] do
  connection    mysql_connection_info
  password      node[:lamp][:mysql][:password]
  database_name db_name
  host          'localhost'
  privileges    [:all]
  action        :grant
end

package 'curl'
