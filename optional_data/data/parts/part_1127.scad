// Flanged spacer.
$fn = 60;
eps = 0.02;
inner_d = 4;
outer_d = 8;
length = 8;
flange_d = 15;
difference() { union() { cylinder(d=outer_d,h=length); cylinder(d=flange_d,h=2); } translate([0,0,-eps]) cylinder(d=inner_d,h=length+2*eps); }
