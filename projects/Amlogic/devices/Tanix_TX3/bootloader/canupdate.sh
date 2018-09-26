# allow upgrades from S905 generic builds

if [ "$1" = "S905.aarch64" ] || [ "$1" = "S905.arm" ]; then
  exit 0
else
  exit 1
fi
