// Split shaft coupling 5 mm to 6 mm.
$fn = 60;
eps = 0.02;
shaft_a = 5;
shaft_b = 6;
outer_d = 20;
length = 28;
slit_w = 1.8;
screw_d = 3.4;
module clamp_hole(z) {
    translate([outer_d / 2 - 3.5, -outer_d / 2 - eps, z]) rotate([-90, 0, 0]) cylinder(d = screw_d, h = outer_d + 2 * eps);
    translate([outer_d / 2 - 3.5, outer_d / 2 - 3 - eps, z]) rotate([-90, 0, 0]) cylinder(d = 6.6, h = 3 + 2 * eps);
}
difference() {
    cylinder(d = outer_d, h = length);
    translate([0, 0, -eps]) cylinder(d = shaft_a, h = length / 2 + eps);
    translate([0, 0, length / 2 - eps]) cylinder(d = shaft_b, h = length / 2 + eps);
    translate([0, -slit_w / 2, -eps]) cube([outer_d / 2 + eps, slit_w, length + 2 * eps]);
    clamp_hole(length / 4);
    clamp_hole(3 * length / 4);
}
