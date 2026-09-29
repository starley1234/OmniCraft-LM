// Ventilated bearing cover plate.
$fn = 60;
eps = 0.02;
bearing_d = 28;
plate_d = 48;
thickness = 3;
difference() {
    cylinder(d=plate_d,h=thickness);
    translate([0,0,-eps]) cylinder(d=bearing_d*0.45,h=thickness+2*eps);
    for (i=[0:5]) rotate([0,0,i*60]) translate([plate_d*0.32,0,-eps]) cylinder(d=4,h=thickness+2*eps);
    for (i=[0:3]) rotate([0,0,i*120+30]) translate([plate_d/2-5,0,-eps]) cylinder(d=3.4,h=thickness+2*eps);
}
