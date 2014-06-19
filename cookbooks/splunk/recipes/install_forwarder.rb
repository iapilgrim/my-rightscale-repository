
splunk_installer 'splunkforwarder' do
  url node['splunk']['forwarder']['url']
end
