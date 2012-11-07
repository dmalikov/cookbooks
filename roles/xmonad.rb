name "xmonad"
description "XMonad"

run_list(
  "recipe[xmonad::default]"
)

default_attributes( {
  "xmobar" => {
    "flags" => [ "with_xft", "with_mpd", "with_alsa" ]
  }
} )
