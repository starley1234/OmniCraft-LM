// U pivot bracket, 28 mm opening.
$fn = 60;
eps = 0.02;
base_l = 56;
base_w = 40;
base_t = 6;
ear_t = 6;
ear_h = 30;
pivot_d = 5.4;
module mount(x) {
    hull() {
        translate([x - 5, 0, -eps]) cylinder(d = 5.4, h = base_t + 2 * eps);
        translate([x + 5, 0, -eps]) cylinder(d = 5.4, h = base_t + 2 * eps);
    }
}
difference() {
    union() {
        translate([-base_l / 2, -base_w / 2, 0]) cube([base_l, base_w, base_t]);
        translate([-ear_t / 2, -base_w / 2, base_t - 2]) cube([ear_t, ear_t, ear_h]);
        translate([-ear_t / 2, base_w / 2 - ear_t, base_t - 2]) cube([ear_t, ear_t, ear_h]);
    }
    mount(-14); mount(14);
    translate([0, -base_w / 2 - eps, ear_h / 2]) rotate([-90, 0, 0]) cylinder(d = pivot_d, h = base_w + 2 * eps);
}
