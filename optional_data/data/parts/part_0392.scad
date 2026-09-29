// GT2 tensioner slide 9 mm: GT2 idler tensioner slide for a 9 mm belt.
$fn = 60;
eps = 0.02;
slide_l = 92;
slide_w = 42;
slide_t = 8;
belt_w = 9;
mount_slot_l = 32;
mount_d = 5.4;
axle_d = 5.4;
axle_x = 30;

module horizontal_slot(x, y) {
    hull() {
        translate([x - mount_slot_l / 2, y, -slide_t / 2 - eps]) cylinder(d = mount_d, h = slide_t + 2 * eps);
        translate([x + mount_slot_l / 2, y, -slide_t / 2 - eps]) cylinder(d = mount_d, h = slide_t + 2 * eps);
    }
}

difference() {
    cube([slide_l, slide_w, slide_t], center = true);
    horizontal_slot(-20, -11);
    horizontal_slot(-20, 11);
    translate([axle_x, 0, -slide_t / 2 - eps]) cylinder(d = axle_d, h = slide_t + 2 * eps);
}
