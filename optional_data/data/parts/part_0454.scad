// Precision shim ring.
$fn = 60;
eps = 0.02;
inner_d = 6;
outer_d = 14;
thickness = 0.8;
difference() {
    cylinder(d = outer_d, h = thickness);
    translate([0, 0, -eps]) cylinder(d = inner_d, h = thickness + 2 * eps);
}
