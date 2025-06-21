<div align="center">
<p align="center">
  <img src="media/preview.gif" alt="Screenshot">
</p>

# Blazing Fast MacOS Window Snap Manager

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

</div>
<br><br>
 
After years on XFCE, I couldn’t live without true magnetic window tiling. macOS still hasn’t caught up, so I built a tiny, pure Lua script for Hammerspoon that fills the gap. It delivers blazing-fast, multi-monitor window snapping just drag to an edge or corner and the window lands exactly where you expect.


## ✨ Why you’ll love it

| Drag gesture | Result |
|--------------|--------|
| **Left edge** | Full-height, left half |
| **Right edge** | Full-height, right half |
| **Any corner** | Perfect quarter-tile |

* **Feels native** – window hops in/out of zones while you *still* hold the mouse.  
* **Pixel-accurate** – when you leave a zone the window stays glued to your cursor.  
* **Works on every display** – whichever monitor the pointer is over.  
* **Zero lag, zero animation** – as snappy as XFCE.  
* **One-file plugin** – clone, add one line to `init.lua`, done.
 

## ⚡️ Quick install
First of all you need to install Hammerspoon https://www.hammerspoon.org/

After that clone this repository into your User hammerspoon directory

```bash
# clone into your Hammerspoon config directory
~/.hammerspoon/macos-window-snap
~/.hammerspoon/init.lua
```

Open Hammerspoon preferences and select **Launch Hammerspoon at login**, click the hammerspoon toolbar icon and hit **Reload Config** and you are ready to go.