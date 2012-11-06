chef_root = File.dirname(File.expand_path(__FILE__))

file_backup_path    chef_root + "/backup"
checksum_path       chef_root + "/cache/checksums"
cookbook_path       chef_root + "/cookbooks"
file_cache_path     chef_root
json_attribs        chef_root + "/config.json"
node_name           %x{ uname -n }.chomp
role_path           chef_root + "/roles"

cache_options({
  :path => platform_specific_path("#{chef_root}/cache/checksums"),
  :skip_expires => true 
})
