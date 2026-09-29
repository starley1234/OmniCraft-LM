// 608 bearing mounting plate
// Flanged 608 bearing pocket with a 4 mm bottom and four mounting slots.
$fn = 60;
eps = 0.02;
base_w = 56;
base_h = 56;
base_t = 12;
bearing_d = 22.2;
bearing_depth = 8;
bottom_t = base_t - bearing_depth;
slot_l = 8;
slot_d = 4.3;
mount_pitch = 40;

module mounting_slot(x, y) {
    hull() {
        translate([x - slot_l / 2, y, -eps]) cylinder(d = slot_d, h = base_t + 2 * eps);
        translate([x + slot_l / 2, y, -eps]) cylinder(d = slot_d, h = base_t + 2 * eps);
    }
}

difference() {
    cube([base_w, base_h, base_t], center = true);
    translate([0, 0, base_t / 2 - bearing_depth - eps])
        cylinder(d = bearing_d, h = bearing_depth + 2 * eps);
    for (x = [-mount_pitch / 2, mount_pitch / 2], y = [-mount_pitch / 2, mount_pitch / 2])
        mounting_slot(x, y);
}
