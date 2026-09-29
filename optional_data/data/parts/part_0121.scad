// Rivet nut / nutsert.
$fn = 60;
eps = 0.02;
thread_d = 8.4;
outer_d = 15;
length = 14;
flange_d = 22;
difference() { union() { cylinder(d=max(outer_d, thread_d+3),h=length); cylinder(d=max(flange_d, thread_d+6),h=2); } translate([0,0,-eps]) cylinder(d=thread_d,h=length+2*eps); }
