// DIN-rail retaining clip.
$fn = 60;
eps = 0.02;
clip_w = 20;
clip_h = 26;
clip_t = 3;
difference() { cube([clip_w,clip_t,clip_h]); translate([clip_w/2, -eps, clip_h*0.45]) cube([clip_w*0.62,clip_t+2*eps,clip_h*0.28],center=true); translate([clip_w/2, -eps, clip_h*0.8]) cube([clip_w*0.42,clip_t+2*eps,clip_h*0.18],center=true); }
