// Rivet nut / nutsert.
$fn = 60;
eps = 0.02;
thread_d = 21;
outer_d = 32;
length = 26;
flange_d = 42;
difference() { union() { cylinder(d=max(outer_d, thread_d+3),h=length); cylinder(d=max(flange_d, thread_d+6),h=2); } translate([0,0,-eps]) cylinder(d=thread_d,h=length+2*eps); }
