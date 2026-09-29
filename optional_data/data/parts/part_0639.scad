// External retaining ring with installation gap.
$fn = 60;
eps = 0.02;
shaft_d = 5;
outer_d = 12;
thickness = 1;
gap = 3;
difference() {
    cylinder(d = outer_d, h = thickness);
    translate([0, 0, -eps]) cylinder(d = shaft_d, h = thickness + 2 * eps);
    translate([outer_d / 2 - gap / 2, -gap / 2, -eps]) cube([gap + eps, gap, thickness + 2 * eps]);
}
