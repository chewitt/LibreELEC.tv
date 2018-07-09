# allow upgrades from older KVIM2 community builds

if [ "$1" = "KVIM2.aarch64" ] || [ "$1" = "KVIM2.arm" ]; then
  exit 0
else
  exit 1
fi
