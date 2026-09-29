// Two-leaf hinge with a printable straight pin barrel.
$fn = 60;
eps = 0.02;
leaf_l = 35;
leaf_w = 35;
leaf_t = 3;
pin_d = 4;
barrel_d = pin_d + 4;
difference() {
    union() {
        translate([-leaf_l, -leaf_w / 2, 0]) cube([leaf_l, leaf_w, leaf_t]);
        translate([0, -leaf_w / 2, 0]) cube([leaf_l, leaf_w, leaf_t]);
        translate([0, -leaf_w / 2, leaf_t / 2]) rotate([-90, 0, 0]) cylinder(d = barrel_d, h = leaf_w);
    }
    translate([0, -leaf_w / 2 - eps, leaf_t / 2]) rotate([-90, 0, 0]) cylinder(d = pin_d, h = leaf_w + 2 * eps);
    for (x = [-leaf_l * 0.55, leaf_l * 0.55], y = [-leaf_w * 0.28, leaf_w * 0.28])
        translate([x, y, -eps]) cylinder(d = 3.4, h = leaf_t + 2 * eps);
}
