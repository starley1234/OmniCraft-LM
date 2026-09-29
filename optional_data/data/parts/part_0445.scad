// NEMA 17 adapter spacer: NEMA 17 face spacer / adapter plate.
$fn = 60;
eps = 0.02;
plate_w = 60;
plate_h = 60;
plate_t = 6;
nema_pitch = 31;
center_d = 23;
mount_d = 3.6;

module counterbored_hole(x, y) {
    translate([x, y, -plate_t / 2 - eps]) cylinder(d = mount_d, h = plate_t + 2 * eps);
    translate([x, y, plate_t / 2 - 2.2]) cylinder(d = 7, h = 2.2 + eps);
}

difference() {
    cube([plate_w, plate_h, plate_t], center = true);
    translate([0, 0, -plate_t / 2 - eps]) cylinder(d = center_d, h = plate_t + 2 * eps);
    for (x = [-nema_pitch / 2, nema_pitch / 2], y = [-nema_pitch / 2, nema_pitch / 2]) counterbored_hole(x, y);
}
