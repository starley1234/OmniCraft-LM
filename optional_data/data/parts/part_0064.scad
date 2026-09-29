// M5 idler pulley tensioner bracket
// Double-ear idler bracket for an M5 axle; ears and base overlap by 2 mm.
$fn = 60;
eps = 0.02;
base_l = 80;
base_w = 42;
base_t = 6;
ear_t = 6;
ear_h = 32;
axle_d = 5.4;
mount_slot_l = 14;
mount_slot_d = 5.4;
axle_x = 54;
axle_z = 22;

module mounting_slot(x) {
    hull() {
        translate([x - mount_slot_l / 2, 0, -eps]) cylinder(d = mount_slot_d, h = base_t + 2 * eps);
        translate([x + mount_slot_l / 2, 0, -eps]) cylinder(d = mount_slot_d, h = base_t + 2 * eps);
    }
}

difference() {
    union() {
        translate([0, -base_w / 2, 0]) cube([base_l, base_w, base_t]);
        translate([axle_x - ear_t / 2, -base_w / 2, base_t - 2]) cube([ear_t, ear_t, ear_h]);
        translate([axle_x - ear_t / 2, base_w / 2 - ear_t, base_t - 2]) cube([ear_t, ear_t, ear_h]);
    }
    mounting_slot(18);
    mounting_slot(38);
    translate([axle_x, -base_w / 2 - eps, axle_z])
        rotate([-90, 0, 0]) cylinder(d = axle_d, h = base_w + 2 * eps);
}
