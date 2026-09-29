// NEMA 17 L tension bracket
// Rigid NEMA 17 L bracket with two overlapping hull gussets and tension slots.
$fn = 60;
eps = 0.02;
base_w = 70;
base_d = 70;
base_t = 5;
upright_t = 6;
upright_h = 60;
nema_pitch = 31;
center_clearance_d = 23;
motor_mount_d = 3.6;
slot_length = 16;
slot_d = 4.2;
gusset_w = 7;
gusset_run = 26;

module base_slot(x, y) {
    hull() {
        translate([x - slot_length / 2, y, -eps]) cylinder(d = slot_d, h = base_t + 2 * eps);
        translate([x + slot_length / 2, y, -eps]) cylinder(d = slot_d, h = base_t + 2 * eps);
    }
}

module gusset(x) {
    hull() {
        translate([x, -base_d / 2 + upright_t - eps, base_t - eps])
            cube([gusset_w, gusset_run, base_t]);
        translate([x, -base_d / 2 + upright_t - eps, upright_h - 8])
            cube([gusset_w, upright_t + eps, base_t]);
    }
}

difference() {
    union() {
        translate([-base_w / 2, -base_d / 2, 0]) cube([base_w, base_d, base_t]);
        translate([-base_w / 2, -base_d / 2, 0]) cube([base_w, upright_t, upright_h]);
        gusset(-base_w / 2 + 7);
        gusset(base_w / 2 - 14);
    }
    translate([0, -base_d / 2 - eps, upright_h / 2])
        rotate([-90, 0, 0]) cylinder(d = center_clearance_d, h = upright_t + 2 * eps);
    for (x = [-nema_pitch / 2, nema_pitch / 2], z = [-nema_pitch / 2, nema_pitch / 2])
        translate([x, -base_d / 2 - eps, upright_h / 2 + z])
            rotate([-90, 0, 0]) cylinder(d = motor_mount_d, h = upright_t + 2 * eps);
    base_slot(-base_w / 4, 14);
    base_slot(base_w / 4, 14);
}
