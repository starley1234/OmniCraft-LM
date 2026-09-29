// Flanged spacer.
$fn = 60;
eps = 0.02;
inner_d = 8;
outer_d = 14;
length = 14;
flange_d = 24;
difference() { union() { cylinder(d=outer_d,h=length); cylinder(d=flange_d,h=2); } translate([0,0,-eps]) cylinder(d=inner_d,h=length+2*eps); }
