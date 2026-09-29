// Reinforced right-angle gusset for 40 mm profile.
$fn = 60;
eps = 0.02;
profile = 40;
arm = 70;
plate_t = 6;
rib_t = 4;
rib_h = 32;
module rib_x() {
    translate([profile, 0, plate_t - eps]) linear_extrude(height = rib_h)
        polygon(points = [[0, 0], [arm - profile, 0], [0, rib_t]]);
}
module rib_y() {
    translate([profile, profile, plate_t - eps]) rotate([0, 0, 90]) linear_extrude(height = rib_h)
        polygon(points = [[0, 0], [arm - profile, 0], [0, rib_t]]);
}
difference() {
    union() { cube([arm, profile, plate_t]); cube([profile, arm, plate_t]); rib_x(); rib_y(); }
    for (p = [[profile / 2, arm - profile / 2], [arm - profile / 2, profile / 2]])
        translate([p[0], p[1], -eps]) cylinder(d = 5.4, h = plate_t + 2 * eps);
}
