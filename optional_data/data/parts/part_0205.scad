// Threaded mounting boss.
$fn = 60;
eps = 0.02;
thread_d = 3.4;
base_d = 12;
height = 8;
difference() { union() { cylinder(d=base_d,h=3); cylinder(d=thread_d+6,h=height); } translate([0,0,-eps]) cylinder(d=thread_d,h=height+2*eps); }
