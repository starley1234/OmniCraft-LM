// Quarter-turn cam lock.
$fn = 60;
eps = 0.02;
body_d = 12;
body_l = 16;
arm_l = 12;
difference() { union() { cylinder(d=body_d,h=body_l); translate([0,-2,body_l-2]) cube([arm_l,4,3]); } translate([0,0,-eps]) cylinder(d=6,h=body_l+2*eps); }
