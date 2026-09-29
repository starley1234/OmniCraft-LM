// C-style split collar for 12 mm shaft.
$fn = 60;
eps = 0.02;
shaft_d = 12;
outer_d = 26;
width = 14;
slit_w = 1.8;
screw_d = 4.3;
difference() {
    cylinder(d = outer_d, h = width);
    translate([0, 0, -eps]) cylinder(d = shaft_d, h = width + 2 * eps);
    translate([0, -slit_w / 2, -eps]) cube([outer_d / 2 + eps, slit_w, width + 2 * eps]);
    translate([outer_d / 2 - 3, -outer_d / 2 - eps, width / 2]) rotate([-90, 0, 0]) cylinder(d = screw_d, h = outer_d + 2 * eps);
    translate([outer_d / 2 - 3, outer_d / 2 - 3 - eps, width / 2]) rotate([-90, 0, 0]) cylinder(d = screw_d + 3, h = 3 + 2 * eps);
}
