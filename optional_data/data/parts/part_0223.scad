// Wall-mount standoff with screw flange.
$fn = 60;
eps = 0.02;
thread_d = 13;
base_d = 30;
length = 28;
difference() { union() { cylinder(d=base_d,h=2); cylinder(d=thread_d+5,h=length); } translate([0,0,-eps]) cylinder(d=thread_d,h=length+2*eps); }
