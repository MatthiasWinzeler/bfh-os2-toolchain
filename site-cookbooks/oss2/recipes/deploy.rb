package 'sqlite3'
package 'libsqlite3-dev'
package 'nodejs'

cookbook_file '/tmp/Gemfile' do
  source 'Gemfile'
end

cookbook_file '/etc/init.d/nginx' do
    source 'nginx.service'
end

cookbook_file '/opt/nginx/conf/nginx.conf' do
  source 'nginx.conf'
end

directory '/opt/nginx/sites' do
  owner 'nobody'
  action :create
end

directory '/opt/nginx/sites/oss2' do
  owner 'nobody'
  action :create
end

bash 'site installer' do
  code <<-EOH
  chown -R nobody /opt/nginx/sites/oss2
  sudo chmod +x /etc/init.d/nginx
  sudo update-rc.d -f nginx defaults
  EOH
end

execute 'start nginx' do
  command '/opt/nginx/sbin/nginx'
end
