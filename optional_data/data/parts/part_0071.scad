// Bearing mounting plate with 16.2 mm pocket.
$fn = 60;
eps = 0.02;
plate_w = 50.2;
plate_t = 10;
bearing_d = 16.2;
pocket_d = 6;
mount_pitch = 32.2;
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
