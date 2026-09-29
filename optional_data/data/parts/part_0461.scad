// Precision shim ring.
$fn = 60;
eps = 0.02;
inner_d = 20;
outer_d = 36;
thickness = 1.5;
difference() {
    cylinder(d = outer_d, h = thickness);
    translate([0, 0, -eps]) cylinder(d = inner_d, h = thickness + 2 * eps);
}
