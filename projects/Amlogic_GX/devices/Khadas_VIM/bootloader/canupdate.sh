# allow upgrades between older KVIM community builds

if [ "$1" = "KVIM.aarch64" ] || [ "$1" = "KVIM.arm" ]; then
  exit 0
else
  exit 1
fi
