// M3 captive-nut plate: captive hex-nut mounting plate.
$fn = 60;
eps = 0.02;
plate_l = 48;
plate_w = 28;
plate_t = 8;
mount_pitch = 34;
mount_d = 4.2;
nut_flat = 5.7;
nut_depth = 4.2;
thread_clearance_d = 3.4;

// The hex pocket leaves at least 3.8 mm of material below the nut.
difference() {
    cube([plate_l, plate_w, plate_t], center = true);
    for (x = [-mount_pitch / 2, mount_pitch / 2])
        translate([x, 0, -plate_t / 2 - eps]) cylinder(d = mount_d, h = plate_t + 2 * eps);
    translate([0, 0, plate_t / 2 - nut_depth])
        cylinder(d = nut_flat / cos(30), h = nut_depth + eps, $fn = 6);
    translate([0, 0, -plate_t / 2 - eps])
        cylinder(d = thread_clearance_d, h = plate_t + 2 * eps);
}
