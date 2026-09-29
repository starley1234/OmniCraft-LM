// Flat metric washer.
$fn = 60;
eps = 0.02;
inner_d = 6.4;
outer_d = 12;
thickness = 1.6;
difference() {
    cylinder(d = outer_d, h = thickness);
    translate([0, 0, -eps]) cylinder(d = inner_d, h = thickness + 2 * eps);
}
