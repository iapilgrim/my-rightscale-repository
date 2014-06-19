
group node['splunk']['user']['username'] do
  gid node['splunk']['user']['uid'].to_i # CHEF-4927
  system true if %w{linux}.include?(node['os'])
end

user node['splunk']['user']['username'] do
  comment node['splunk']['user']['comment']
  shell node['splunk']['user']['shell']
  gid node['splunk']['user']['username']
  uid node['splunk']['user']['uid']
  system true if %w{linux}.include?(node['os'])
end
