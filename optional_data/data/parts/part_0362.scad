// Flat metric washer.
$fn = 60;
eps = 0.02;
inner_d = 17;
outer_d = 30;
thickness = 3;
difference() {
    cylinder(d = outer_d, h = thickness);
    translate([0, 0, -eps]) cylinder(d = inner_d, h = thickness + 2 * eps);
}
