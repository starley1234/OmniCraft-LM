// Bearing mounting plate with 35.2 mm pocket.
$fn = 60;
eps = 0.02;
plate_w = 69.2;
plate_t = 14;
bearing_d = 35.2;
pocket_d = 10;
mount_pitch = 51.2;
module slot(x, y) {
    hull() {
        translate([x - 4, y, -plate_t / 2 - eps]) cylinder(d = 4.3, h = plate_t + 2 * eps);
        translate([x + 4, y, -plate_t / 2 - eps]) cylinder(d = 4.3, h = plate_t + 2 * eps);
    }
}
difference() {
    cube([plate_w, plate_w, plate_t], center = true);
    translate([0, 0, plate_t / 2 - pocket_d - eps]) cylinder(d = bearing_d, h = pocket_d + 2 * eps);
    for (x = [-mount_pitch / 2, mount_pitch / 2], y = [-mount_pitch / 2, mount_pitch / 2]) slot(x, y);
}
