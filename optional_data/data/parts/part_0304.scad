// Split shaft collar 8 mm: one-piece C-style split shaft collar.
$fn = 60;
eps = 0.02;
shaft_d = 8;
outer_d = 22;
width = 12;
slit_w = 1.8;
clamp_screw_d = 4.3;
head_d = 7.3;

module clamp_bore() {
    translate([outer_d / 2 - 3.5, -outer_d / 2 - eps, width / 2])
        rotate([-90, 0, 0]) cylinder(d = clamp_screw_d, h = outer_d + 2 * eps);
    translate([outer_d / 2 - 3.5, outer_d / 2 - 3 - eps, width / 2])
        rotate([-90, 0, 0]) cylinder(d = head_d, h = 3 + 2 * eps);
}

difference() {
    cylinder(d = outer_d, h = width);
    translate([0, 0, -eps]) cylinder(d = shaft_d, h = width + 2 * eps);
    translate([0, -slit_w / 2, -eps]) cube([outer_d / 2 + eps, slit_w, width + 2 * eps]);
    clamp_bore();
}
