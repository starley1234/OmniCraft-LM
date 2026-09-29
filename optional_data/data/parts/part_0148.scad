// Shaft-seal holder plate.
$fn = 60;
eps = 0.02;
seal_d = 8;
outer_d = 20;
plate_t = 4;
difference() { cylinder(d=outer_d,h=plate_t); translate([0,0,-eps]) cylinder(d=seal_d,h=plate_t+2*eps); for(i=[0:3]) rotate([0,0,i*90]) translate([outer_d/2-5,0,-eps]) cylinder(d=4.3,h=plate_t+2*eps); }
