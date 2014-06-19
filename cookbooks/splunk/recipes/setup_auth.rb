splunk_auth_info = node['splunk']['splunk_auth_info']

Chef::Log.debug("Current setting of splunk auth #{splunk_auth_info}.")

user, pw = splunk_auth_info.split(':')

execute 'change-admin-user-password-from-default' do
  command "#{splunk_cmd} edit user #{user} -password '#{pw}' -role admin -auth admin:changeme"
  not_if { ::File.exists?("#{splunk_dir}/etc/.setup_#{user}_password") }
end

file "#{splunk_dir}/etc/.setup_#{user}_password" do
  content 'true\n'
  owner 'root'
  group 'root'
  mode 00600
end
