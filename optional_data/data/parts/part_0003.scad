// NEMA 17 slotted face plate
// Slotted NEMA 17 face plate; all through cuts extend by eps.
$fn = 60;
eps = 0.02;
plate_w = 70;
plate_h = 70;
plate_t = 5;
nema_pitch = 31;
center_clearance_d = 23;
mount_d = 3.6;
slot_length = 12;
slot_d = 4.2;

module vertical_slot(x, y) {
    hull() {
        translate([x, y - slot_length / 2, -plate_t / 2 - eps])
            cylinder(d = slot_d, h = plate_t + 2 * eps);
        translate([x, y + slot_length / 2, -plate_t / 2 - eps])
            cylinder(d = slot_d, h = plate_t + 2 * eps);
    }
}

difference() {
    cube([plate_w, plate_h, plate_t], center = true);
    translate([0, 0, -plate_t / 2 - eps])
        cylinder(d = center_clearance_d, h = plate_t + 2 * eps);
    for (x = [-nema_pitch / 2, nema_pitch / 2])
        vertical_slot(x, 0);
}
