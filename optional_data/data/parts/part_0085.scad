// Hex-head bolt.
$fn = 60;
eps = 0.02;
thread_d = 5.4;
flat = 8;
shaft_l = 16;
union() { cylinder(d=thread_d,h=shaft_l); translate([0,0,shaft_l]) cylinder(d=flat/cos(30),h=flat*0.45,$fn=6); }
