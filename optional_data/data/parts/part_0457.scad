// Precision shim ring.
$fn = 60;
eps = 0.02;
inner_d = 10;
outer_d = 20;
thickness = 1;
difference() {
    cylinder(d = outer_d, h = thickness);
    translate([0, 0, -eps]) cylinder(d = inner_d, h = thickness + 2 * eps);
}
