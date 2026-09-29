// Round spacer.
$fn = 60;
eps = 0.02;
inner_d = 21;
outer_d = 38;
length = 36;
difference() { cylinder(d=outer_d,h=length); translate([0,0,-eps]) cylinder(d=inner_d,h=length+2*eps); }
