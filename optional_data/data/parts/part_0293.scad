// Split shaft collar 5 mm: one-piece C-style split shaft collar.
$fn = 60;
eps = 0.02;
shaft_d = 5;
outer_d = 16;
width = 10;
slit_w = 1.8;
clamp_screw_d = 3.4;
head_d = 6.4;

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
