file "/wat" do
  owner "root"
  group "root"
  mode 0644
end

template "/derp" do
  owner "root"
  group "root"
  action :create
end

template '/derp2' do
  owner "root"
  group "root"
  action :create
end
