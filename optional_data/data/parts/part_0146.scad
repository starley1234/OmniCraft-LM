// U-shaped spring clip.
$fn = 60;
eps = 0.02;
clip_w = 32;
clip_h = 32;
clip_t = 4;
union() { cube([clip_w,clip_t,clip_t]); translate([0,0,clip_h-clip_t]) cube([clip_w,clip_t,clip_t]); cube([clip_t,clip_t,clip_h]); translate([clip_w-clip_t,0,0]) cube([clip_t,clip_t,clip_h]); }
