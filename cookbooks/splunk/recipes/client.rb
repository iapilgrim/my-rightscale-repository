include_recipe 'splunk::user'
include_recipe 'splunk::install_forwarder'

splunk_servers = node['splunk']['servers']

# ensure that the splunk service resource is available without cloning
# the resource (CHEF-3694). this is so the later notification works,
# especially when using chefspec to run this cookbook's specs.
begin
  resources('service[splunk]')
rescue Chef::Exceptions::ResourceNotFound
  service 'splunk'
end

directory "#{splunk_dir}/etc/system/local" do
  recursive true
  owner node['splunk']['user']['username']
  group node['splunk']['user']['username']
end

template "#{splunk_dir}/etc/system/local/outputs.conf" do
  source 'outputs.conf.erb'
  mode 0644
  variables :splunk_servers => splunk_servers
  notifies :restart, 'service[splunk]'
end

include_recipe 'splunk::service'
include_recipe 'splunk::setup_auth'