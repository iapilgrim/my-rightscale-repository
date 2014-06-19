#
# Cookbook Name:: splunk
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#


log "  Installing Chef Vault gem"
# gem_package "chef-vault" do
# 	gem_binary "/usr/bin/gem"
# 	# version "3.0.19"
# 	action :install
# end

chef_gem "chef_vault" do
  action :install
end
include_recipe 'chef-vault'

if node['splunk']['disabled']
  include_recipe 'chef-splunk::disabled'
  Chef::Log.debug('Splunk is disabled on this node.')
  return
end

if node['splunk']['is_server']
  include_recipe 'splunk::server'
else
  include_recipe 'splunk::client'
end