// LM8UU split housing: split linear-bearing housing with mounting slots.
$fn = 60;
eps = 0.02;
bearing_d = 15;
body_l = 54;
body_d = 34;
body_h = 30;
slot_w = 2;
clamp_screw_d = 4.2;
mount_slot_l = 10;
mount_slot_d = 5.4;

module mount_slot(x) {
    hull() {
        translate([x - mount_slot_l / 2, 0, -body_h / 2 - eps]) cylinder(d = mount_slot_d, h = 8 + 2 * eps);
        translate([x + mount_slot_l / 2, 0, -body_h / 2 - eps]) cylinder(d = mount_slot_d, h = 8 + 2 * eps);
    }
}

difference() {
    cube([body_l, body_d, body_h], center = true);
    translate([0, -body_d / 2 - eps, 0])
        rotate([-90, 0, 0]) cylinder(d = bearing_d + 0.25, h = body_d + 2 * eps);
    translate([-slot_w / 2, -body_d / 2 - eps, 0]) cube([slot_w, body_d + 2 * eps, body_h / 2 + eps]);
    translate([-body_l / 2 - eps, 0, body_h / 2 - 6])
        rotate([0, 90, 0]) cylinder(d = clamp_screw_d, h = body_l + 2 * eps);
    mount_slot(-16);
    mount_slot(16);
}
