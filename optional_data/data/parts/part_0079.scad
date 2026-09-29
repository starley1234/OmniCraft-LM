// Flanged spacer.
$fn = 60;
eps = 0.02;
inner_d = 14;
outer_d = 20;
length = 20;
flange_d = 36;
difference() { union() { cylinder(d=outer_d,h=length); cylinder(d=flange_d,h=2); } translate([0,0,-eps]) cylinder(d=inner_d,h=length+2*eps); }
