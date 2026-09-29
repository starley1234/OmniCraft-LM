// Keyway hub for a 20 mm shaft.
$fn = 60;
eps = 0.02;
shaft_d = 20;
outer_d = 40;
length = 32;
key_w = 6;
key_depth = 3.3000000000000003;
difference() {
    cylinder(d = outer_d, h = length);
    translate([0, 0, -eps]) cylinder(d = shaft_d, h = length + 2 * eps);
    translate([shaft_d / 2 - eps, -key_w / 2, -eps]) cube([key_depth + 2 * eps, key_w, length + 2 * eps]);
    translate([-outer_d / 2 - eps, 0, length / 2]) rotate([0, 90, 0]) cylinder(d = 3.3, h = outer_d / 2 + 2 * eps);
}
