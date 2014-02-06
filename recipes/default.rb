include_recipe "nodejs::install_from_binary"

execute "Install yeoman" do
  command "npm install -g yo"
  not_if "npm -g ls 2> /dev/null | grep '^│ └─┬ yeoman-generator'"
end

node['yeoman']['generators'].each do |pkg_name|
  execute "Install generator-#{pkg_name}" do
    command "npm install -g generator-#{pkg_name}"
    not_if "npm -g ls 2> /dev/null | grep '^[├└]─[─┬] #{pkg_name}'"
  end
end

execute "Install grunt-contrib-compass" do
  command "npm install -g grunt-contrib-compass --save-dev"
  not_if "npm -g ls 2> /dev/null | grep '^[├└]─[─┬] grunt-contrib-compass'"
end

gem_package "compass" do
  action :install
end
