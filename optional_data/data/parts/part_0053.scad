// 2020 corner bracket 60 mm
// 2020 aluminium-profile corner with ribs that overlap the L legs by eps.
$fn = 60;
eps = 0.02;
profile = 20;
arm = 60;
plate_t = 6;
rib_t = 4;
rib_h = 24;
hole_d = 5.4;
counterbore_d = 9;
counterbore_h = 2.2;

module rib_x() {
    translate([profile, 0, plate_t - eps])
        linear_extrude(height = rib_h)
            polygon(points = [[0, 0], [arm - profile, 0], [0, rib_t]]);
}

module rib_y() {
    translate([profile, profile, plate_t - eps])
        rotate([0, 0, 90])
            linear_extrude(height = rib_h)
                polygon(points = [[0, 0], [arm - profile, 0], [0, rib_t]]);
}

difference() {
    union() {
        cube([arm, profile, plate_t]);
        cube([profile, arm, plate_t]);
        rib_x();
        rib_y();
    }
    for (p = [[profile / 2, arm - profile / 2], [arm - profile / 2, profile / 2]]) {
        translate([p[0], p[1], -eps]) cylinder(d = hole_d, h = plate_t + 2 * eps);
        translate([p[0], p[1], plate_t - counterbore_h])
            cylinder(d = counterbore_d, h = counterbore_h + eps);
    }
}
