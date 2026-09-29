// 625 bearing mounting plate: flanged bearing pocket with a solid bottom web.
$fn = 60;
eps = 0.02;
plate_w = 58;
plate_h = 58;
plate_t = 12;
bearing_d = 16.2;
pocket_depth = 6;
mount_pitch = 42;
mount_d = 4.3;

module slot(x, y) {
    hull() {
        translate([x - 4, y, -plate_t / 2 - eps]) cylinder(d = mount_d, h = plate_t + 2 * eps);
        translate([x + 4, y, -plate_t / 2 - eps]) cylinder(d = mount_d, h = plate_t + 2 * eps);
    }
}

difference() {
    cube([plate_w, plate_h, plate_t], center = true);
    translate([0, 0, plate_t / 2 - pocket_depth - eps])
        cylinder(d = bearing_d, h = pocket_depth + 2 * eps);
    for (x = [-mount_pitch / 2, mount_pitch / 2], y = [-mount_pitch / 2, mount_pitch / 2]) slot(x, y);
}
