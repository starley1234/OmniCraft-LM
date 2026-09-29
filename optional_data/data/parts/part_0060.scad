// Split housing for 15 mm OD linear bearing.
$fn = 60;
eps = 0.02;
bearing_d = 15;
body_l = 55;
body_d = 31;
body_h = 29;
slot_w = 2;
module mount_slot(x) {
    hull() {
        translate([x - 5, 0, -body_h / 2 - eps]) cylinder(d = 5.4, h = 8 + 2 * eps);
        translate([x + 5, 0, -body_h / 2 - eps]) cylinder(d = 5.4, h = 8 + 2 * eps);
    }
}
difference() {
    cube([body_l, body_d, body_h], center = true);
    translate([0, -body_d / 2 - eps, 0]) rotate([-90, 0, 0]) cylinder(d = bearing_d + 0.25, h = body_d + 2 * eps);
    translate([-slot_w / 2, -body_d / 2 - eps, 0]) cube([slot_w, body_d + 2 * eps, body_h / 2 + eps]);
    translate([-body_l / 2 - eps, 0, body_h / 2 - 6]) rotate([0, 90, 0]) cylinder(d = 4.2, h = body_l + 2 * eps);
    mount_slot(-body_l / 4);
    mount_slot(body_l / 4);
}
