// 5 mm shaft pedestal: clamp pedestal for a horizontal precision shaft.
$fn = 60;
eps = 0.02;
shaft_d = 5;
body_l = 46;
body_d = 30;
body_h = 28;
base_t = 6;
slot_w = 2;
clamp_screw_d = 4.2;
mount_d = 5.4;

module mount_slot(x) {
    hull() {
        translate([x - 5, 0, -body_h / 2 - eps]) cylinder(d = mount_d, h = base_t + 2 * eps);
        translate([x + 5, 0, -body_h / 2 - eps]) cylinder(d = mount_d, h = base_t + 2 * eps);
    }
}

difference() {
    cube([body_l, body_d, body_h], center = true);
    translate([0, -body_d / 2 - eps, 4])
        rotate([-90, 0, 0]) cylinder(d = shaft_d + 0.25, h = body_d + 2 * eps);
    // A top slit allows the M4 screw to close the shaft bore.
    translate([-slot_w / 2, -body_d / 2 - eps, 4]) cube([slot_w, body_d + 2 * eps, body_h / 2 + eps]);
    translate([-body_l / 2 - eps, 0, body_h / 2 - 6])
        rotate([0, 90, 0]) cylinder(d = clamp_screw_d, h = body_l + 2 * eps);
    mount_slot(-14);
    mount_slot(14);
}
