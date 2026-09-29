// Wall-mount standoff with screw flange.
$fn = 60;
eps = 0.02;
thread_d = 5.4;
base_d = 16;
length = 14;
difference() { union() { cylinder(d=base_d,h=2); cylinder(d=thread_d+5,h=length); } translate([0,0,-eps]) cylinder(d=thread_d,h=length+2*eps); }
