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
 -- ~/.hammerspoon/macos-window-snap/snap.lua
 ----------------------------------------------------------------
 local M = {}

 ----------------------------------------------------------------
 --  Magnetic snapping while dragging │ pointer-accurate edition
 ----------------------------------------------------------------
 local geom, mouse, eventtap = hs.geometry, hs.mouse, hs.eventtap
 local SNAP_DIST   = 20     -- px from edge/corner to trigger
 
 
 ----------------------------------------------------------------
 --  Helpers
 ----------------------------------------------------------------
 local function getZone(pos, f)
   local l =     pos.x - f.x           < SNAP_DIST
   local r = (f.x+f.w) - pos.x         < SNAP_DIST
   local t =     pos.y - f.y           < SNAP_DIST
   local b = (f.y+f.h) - pos.y         < SNAP_DIST
 
   if l and t then return "topLeft"
   elseif r and t then return "topRight"
   elseif l and b then return "bottomLeft"
   elseif r and b then return "bottomRight"
   elseif l      then return "leftHalf"
   elseif r      then return "rightHalf"
   end
 end
 
 local function frameForZone(f, z)
   local x,y,w,h = f.x, f.y, f.w, f.h
   if     z=="leftHalf"    then return geom(x,       y,       w/2, h)
   elseif z=="rightHalf"   then return geom(x+w/2,   y,       w/2, h)
   elseif z=="topLeft"     then return geom(x,       y,       w/2, h/2)
   elseif z=="topRight"    then return geom(x+w/2,   y,       w/2, h/2)
   elseif z=="bottomLeft"  then return geom(x,       y+h/2,   w/2, h/2)
   elseif z=="bottomRight" then return geom(x+w/2,   y+h/2,   w/2, h/2) end
 end
 
 
 ----------------------------------------------------------------
 -- Per drag state
 ----------------------------------------------------------------
 local activeWin, originalSize, grabOffset
 local snapped = false
 
 
 ----------------------------------------------------------------
 -- Handlers
 ----------------------------------------------------------------
 local function dragHandler()
   local win = hs.window.frontmostWindow()
   if not (win and win:isStandard()) then return false end
 
   local pos = mouse.absolutePosition()
 
   -- This is a new drag, I will remember starting frame & grab-point
   if win ~= activeWin then
     activeWin   = win
     local f     = win:frame()
     originalSize = {w = f.w, h = f.h}
     grabOffset   = {x = pos.x - f.x, y = pos.y - f.y}
     snapped      = false
   end
 
   local scr  = hs.mouse.getCurrentScreen()
   local zone = getZone(pos, scr:frame())
 
   if zone then
     local target = frameForZone(scr:frame(), zone)
     if win:screen() ~= scr then win:moveToScreen(scr, false, true) end
     if not win:frame():equals(target) then win:setFrame(target, 0) end
     snapped = true
   elseif snapped then
     win:setFrame({
       x = pos.x - grabOffset.x,
       y = pos.y - grabOffset.y,
       w = originalSize.w,
       h = originalSize.h
     }, 0)
     snapped = false
   end
   return false
 end
 
 local function upHandler()
   activeWin, originalSize, grabOffset, snapped = nil, nil, nil, false
   return false
 end
 
 
 ----------------------------------------------------------------
 -- Taps (created on demand)
 ----------------------------------------------------------------
 local dragTap, upTap
 
 function M.start()
   if dragTap then return end
   dragTap = eventtap.new(
               { eventtap.event.types.leftMouseDragged }, dragHandler):start()
   upTap   = eventtap.new(
               { eventtap.event.types.leftMouseUp      }, upHandler  ):start()
 
   -- Keep refering globally so Lua GC can’t collect them
   _G.windowSnap_dragTap = dragTap
   _G.windowSnap_upTap   = upTap
 end
 
 function M.stop()
   if dragTap then dragTap:stop(); dragTap = nil end
   if upTap   then upTap:stop();   upTap   = nil end
 end
 
 return M