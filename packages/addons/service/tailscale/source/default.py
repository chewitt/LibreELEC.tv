# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

import subprocess
import xbmc
import xbmcaddon

ADDON = xbmcaddon.Addon()

class Monitor(xbmc.Monitor):

   def __init__(self, *args, **kwargs):
      xbmc.Monitor.__init__(self)
      self.id = xbmcaddon.Addon().getAddonInfo('id')

   def onSettingsChanged(self):
      subprocess.call(['systemctl', 'restart', 'id'])


if __name__ == "__main__":

   if ADDON.getSetting('TAILSCALE_WIZARD') == 'true':
      try:
         ADDON.openSettings(id)
         ADDON.setSetting('TAILSCALE_WIZARD', 'false')
      except:
         pass

   Monitor().waitForAbort()
