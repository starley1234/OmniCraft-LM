// Clamp pedestal for 10 mm shaft.
$fn = 60;
eps = 0.02;
shaft_d = 10;
body_l = 58;
body_d = 32;
body_h = 30;
base_t = 6;
slot_w = 2;
mount_d = 5.4;
module mount_slot(x) {
    hull() {
        translate([x - 5, 0, -body_h / 2 - eps]) cylinder(d = mount_d, h = base_t + 2 * eps);
        translate([x + 5, 0, -body_h / 2 - eps]) cylinder(d = mount_d, h = base_t + 2 * eps);
    }
}
difference() {
    cube([body_l, body_d, body_h], center = true);
    translate([0, -body_d / 2 - eps, 3]) rotate([-90, 0, 0]) cylinder(d = shaft_d + 0.25, h = body_d + 2 * eps);
    translate([-slot_w / 2, -body_d / 2 - eps, 3]) cube([slot_w, body_d + 2 * eps, body_h / 2 + eps]);
    translate([-body_l / 2 - eps, 0, body_h / 2 - 6]) rotate([0, 90, 0]) cylinder(d = 4.2, h = body_l + 2 * eps);
    mount_slot(-body_l / 4);
    mount_slot(body_l / 4);
}
