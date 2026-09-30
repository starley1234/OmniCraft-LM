$fn = 32;
// 60x60x10 фланец с 4 отверстиями М5 по углам.
eps = 0.02;
module chamfer() {
    for (x = -24, 24) {
        translate([x, 0, -eps]) cylinder(d = 24, h = 24);
        translate([x, 0, eps]) cylinder(d = 24, h = 24);
    }
}
difference() {
    cube([60, 60, 10], center = true);
    chamfer();
    translate([0, 0, -eps]) cylinder(d = 20, h = 60 + 2 * eps);
    translate([0, 0, eps]) cylinder(d = 20, h = 60 + 2 * eps);
    translate([0, -eps, -eps]) cylinder(d = 5, h = 60 + 2 * eps);
    translate([0, eps, -eps]) cylinder(d = 5, h = 60 + 2 * eps);
}
