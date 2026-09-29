// Clevis mounting bracket for M5 pin.
$fn = 60;
eps = 0.02;
opening = 32;
ear_h = 34;
base_l = 58;
base_w = opening + 12;
base_t = 6;
ear_t = 6;
difference() {
    union() {
        translate([-base_l / 2, -base_w / 2, 0]) cube([base_l, base_w, base_t]);
        translate([-ear_t / 2, -base_w / 2, base_t - 2]) cube([ear_t, ear_t, ear_h]);
        translate([-ear_t / 2, base_w / 2 - ear_t, base_t - 2]) cube([ear_t, ear_t, ear_h]);
    }
    for (x = [-15, 15]) translate([x, 0, -eps]) cylinder(d = 5.4, h = base_t + 2 * eps);
    translate([0, -base_w / 2 - eps, ear_h / 2]) rotate([-90, 0, 0]) cylinder(d = 5.4, h = base_w + 2 * eps);
}
