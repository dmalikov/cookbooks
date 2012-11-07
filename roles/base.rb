name "base"
description "Base role"

default_attributes( {
  "runtime_user" => {
    "home" => "/home/dmalikov/",
    "uid" => "dmalikov",
    "gid" => "dmalikov"
  }
}
)
