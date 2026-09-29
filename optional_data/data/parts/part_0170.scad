// Lightweight sprocket blank.
$fn = 60;
eps = 0.02;
bore_d = 3;
outer_d = 20;
spoke_holes = 4;
thickness = 6;
difference() { cylinder(d=outer_d,h=thickness); translate([0,0,-eps]) cylinder(d=bore_d,h=thickness+2*eps); for(i=[0:spoke_holes-1]) rotate([0,0,i*360/spoke_holes]) translate([outer_d*0.31,0,-eps]) cylinder(d=5,h=thickness+2*eps); }
