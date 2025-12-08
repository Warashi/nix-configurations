{ lib, notch-height }:
''
  sketchybar --bar position=top height=40 notch_display_height=$(${lib.getExe notch-height}) blur_radius=30 color=0x40000000
''
