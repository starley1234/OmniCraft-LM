// M4 captive-nut plate for compact mechanical fixtures.
$fn = 60;
eps = 0.02;
plate_l = 58;
plate_w = 30;
plate_t = 8;
mount_pitch = 42;
mount_d = 4.3;
nut_flat = 7.0;
nut_depth = 4.4;
thread_clearance_d = 4.3;

// A hex recess is open only from the top, retaining a 3.6 mm bottom web.
difference() {
    cube([plate_l, plate_w, plate_t], center = true);
    for (x = [-mount_pitch / 2, mount_pitch / 2])
        translate([x, 0, -plate_t / 2 - eps]) cylinder(d = mount_d, h = plate_t + 2 * eps);
    translate([0, 0, plate_t / 2 - nut_depth])
        cylinder(d = nut_flat / cos(30), h = nut_depth + eps, $fn = 6);
    translate([0, 0, -plate_t / 2 - eps])
        cylinder(d = thread_clearance_d, h = plate_t + 2 * eps);
}
