# Cookbook Name:: xmonad
#
# Recipe:: default
#

runtime = node["runtime_user"]

xmonad_dir = File.join( runtime["home"],".xmonad" )
xmobarhs_path = File.join( xmonad_dir, "xmobar.hs" )
xmobar_path = File.join( xmonad_dir, "xmobar" )
xmobar_repo_path = File.join( runtime["home"], "dmalikov", "xmobar-usable" )

git xmobar_repo_path do
    repository "git@github.com:dmalikov/xmobar-usable"
    revision "master"
    user runtime["uid"]
    group runtime["gid"]
    action :sync
end

execute "compile xmobar-usable" do
  command "cabal install --flags=\"#{node["xmobar"]["flags"].join(" ")}\""
  action :run
  cwd xmobar_repo_path
end

template xmobar_path do
  source "xmobar.hs.erb"
  mode 0755
  owner runtime["uid"]
  group runtime["gid"]
  variables( {
    "color" => node["xmonad"]["color"],
    "position" => node["xmobar"]["position"],
  } )
end

execute "xmobar recompile" do
  command "ghc -O2 --make #{xmobarhs_path} -o #{xmobar_path} -fforce-recomp"
end

template File.join( xmonad_dir,"xmonad.hs" ) do
  source "xmonad.hs.erb"
  mode 0755
  owner runtime["uid"]
  group runtime["gid"]
  variables( {
    "color" => node["xmonad"]["color"],
  } )
end

execute "xmonad recompile" do
  command "xmonad --recompile"
  timeout 30
end

execute "xmonad restart" do
  command "xmonad --restart"
  timeout 30
end
