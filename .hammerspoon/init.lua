----------------------------------------------------------------------------
--   Extension:   MacOS Window Snap                                       --
--   Author:      elelabdev                                               --
--   Description: Lightning-fast, pixel-perfect window snapping for macOS.--
--                Drag to a corner or left/right edge → instant quarter   --
--                half-tile, multi-monitor-aware, zero animation.         --
--                Powered by Hammerspoon.                                 --
--                                                                        --
--   Github:      https://github.com/elelabdev/macos-window-snap          --
--                                                                        --
--   Icon Author: elelab                                                  --
--                                                                        --
--   Copyright (C) 2025 elelab                                            --
--   https://www.elelab.dev                                               --
--                                                                        --
--   Licensed under the MIT License. See LICENSE file in the project      --
--   root for details.                                                    --
----------------------------------------------------------------------------
 
----------------------------------------------------------------
--  Add the project folder to Lua's search path *once*
----------------------------------------------------------------
local repoPath = hs.configdir .. '/macos-window-snap/?.lua'
if not string.find(package.path, repoPath, 1, true) then
  package.path = package.path .. ';' .. repoPath
end

require('snap').start()