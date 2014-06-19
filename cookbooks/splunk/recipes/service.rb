if node['splunk']['accept_license']
  execute "#{splunk_cmd} enable boot-start --accept-license --answer-yes" do
    not_if { ::File.exists?('/etc/init.d/splunk') }
  end
end

service 'splunk' do
  supports :status => true, :restart => true
  provider Chef::Provider::Service::Init
  action :start
end
