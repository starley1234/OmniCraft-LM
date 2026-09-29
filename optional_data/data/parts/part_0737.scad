// Bearing retaining ring.
$fn = 60;
eps = 0.02;
bearing_d = 35;
outer_d = 54;
thickness = 3.5;
difference() {
    cylinder(d=outer_d,h=thickness);
    translate([0,0,-eps]) cylinder(d=bearing_d,h=thickness+2*eps);
    for (i=[0:3]) rotate([0,0,i*90]) translate([outer_d/2-4,0,-eps]) cylinder(d=3.4,h=thickness+2*eps);
}
