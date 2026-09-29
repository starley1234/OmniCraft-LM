// GT2 idler tensioner slide for 6 mm belt.
$fn = 60;
eps = 0.02;
slide_l = 80;
slide_w = 42;
slide_t = 8;
belt_w = 6;
slot_l = 32;
axle_d = 5.4;
axle_x = slide_l / 2 - 18;
module slot(y) {
    hull() {
        translate([-slide_l / 4 - slot_l / 2, y, -slide_t / 2 - eps]) cylinder(d = 5.4, h = slide_t + 2 * eps);
        translate([-slide_l / 4 + slot_l / 2, y, -slide_t / 2 - eps]) cylinder(d = 5.4, h = slide_t + 2 * eps);
    }
}
difference() {
    cube([slide_l, slide_w, slide_t], center = true);
    slot(-11);
    slot(11);
    translate([axle_x, 0, -slide_t / 2 - eps]) cylinder(d = axle_d, h = slide_t + 2 * eps);
}
