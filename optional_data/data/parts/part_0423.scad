// 2020 reinforced gusset: reinforced right-angle profile gusset.
$fn = 60;
eps = 0.02;
profile = 20;
arm = 50;
plate_t = 6;
rib_t = 4;
rib_h = 24;
hole_d = 5.4;

module x_rib() {
    translate([profile, 0, plate_t - eps])
        linear_extrude(height = rib_h)
            polygon(points = [[0, 0], [arm - profile, 0], [0, rib_t]]);
}
module y_rib() {
    translate([profile, profile, plate_t - eps]) rotate([0, 0, 90])
        linear_extrude(height = rib_h)
            polygon(points = [[0, 0], [arm - profile, 0], [0, rib_t]]);
}

difference() {
    union() {
        cube([arm, profile, plate_t]);
        cube([profile, arm, plate_t]);
        x_rib();
        y_rib();
    }
    for (p = [[profile / 2, arm - profile / 2], [arm - profile / 2, profile / 2]])
        translate([p[0], p[1], -eps]) cylinder(d = hole_d, h = plate_t + 2 * eps);
}
