# allow upgrades between aarch64 and S905 generic builds

if [ "$1" = "WeTek_Hub.aarch64" ] || [ "$1" = "S905.arm" ]; then
  exit 0
else
  exit 1
fi
