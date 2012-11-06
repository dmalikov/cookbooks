# Cookbook Name:: xmonad
#
# Recipe:: default
#

runtime = node[:runtime_user]

xmonad_dir = File.join( runtime[:home],".xmonad" )
xmobarhs_path = File.join( xmonad_dir, "xmobar.hs" )
xmobar_path = File.join( xmonad_dir, "xmobar" )

template xmobar_path do
  source "xmobar.hs.erb"
  mode 0755
  owner runtime[:uid]
  group runtime[:gid]
  variables( {
    :color => node[:color]
  } )
end

template File.join( xmonad_dir,"xmonad.hs" ) do
  source "xmonad.hs.erb"
  mode 0755
  owner runtime[:uid]
  group runtime[:gid]
  variables( {
    :color => node[:color]
  } )
end

execute "xmobar recompile" do
  command "ghc -O2 --make #{xmobarhs_path} -o #{xmobar_path} -fforce-recomp"
end

execute "xmonad recompile" do
  command "xmonad --recompile"
  timeout 30
end

execute "xmonad restart" do
  command "xmonad --restart"
  timeout 30
end
