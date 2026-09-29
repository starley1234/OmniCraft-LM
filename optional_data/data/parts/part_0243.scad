// Closed cable guide ring.
$fn = 60;
eps = 0.02;
cable_d = 8;
outer_d = 20;
thickness = 4;
difference() { cylinder(d=outer_d,h=thickness); translate([0,0,-eps]) cylinder(d=cable_d,h=thickness+2*eps); translate([outer_d/2-3,0,-eps]) cylinder(d=3.4,h=thickness+2*eps); }
