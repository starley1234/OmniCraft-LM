// M5 U pivot bracket: rigid U bracket with two 6 mm ears for an M5 pivot.
$fn = 60;
eps = 0.02;
base_l = 54;
base_w = 36;
base_t = 6;
ear_t = 6;
ear_h = 34;
pivot_d = 5.4;
mount_d = 5.4;

module mount_slot(x) {
    hull() {
        translate([x - 5, 0, -eps]) cylinder(d = mount_d, h = base_t + 2 * eps);
        translate([x + 5, 0, -eps]) cylinder(d = mount_d, h = base_t + 2 * eps);
    }
}

difference() {
    union() {
        translate([-base_l / 2, -base_w / 2, 0]) cube([base_l, base_w, base_t]);
        translate([-ear_t / 2, -base_w / 2, base_t - 2]) cube([ear_t, ear_t, ear_h]);
        translate([-ear_t / 2, base_w / 2 - ear_t, base_t - 2]) cube([ear_t, ear_t, ear_h]);
    }
    mount_slot(-14);
    mount_slot(14);
    translate([0, -base_w / 2 - eps, 22]) rotate([-90, 0, 0]) cylinder(d = pivot_d, h = base_w + 2 * eps);
}
