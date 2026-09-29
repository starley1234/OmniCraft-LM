// Flat 90-degree corner plate.
$fn = 60;
eps = 0.02;
arm = 45;
width = 20;
plate_t = 5;
difference() {
    union() { cube([arm, width, plate_t]); cube([width, arm, plate_t]); }
    for (p = [[width / 2, arm - width / 2], [arm - width / 2, width / 2]])
        translate([p[0], p[1], -eps]) cylinder(d = 5.4, h = plate_t + 2 * eps);
}
