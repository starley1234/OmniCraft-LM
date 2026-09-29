// T8 lead-screw nut holder: T8 lead-screw nut holder with a deep but non-through pocket.
$fn = 60;
eps = 0.02;
body_l = 52;
body_w = 38;
body_t = 12;
nut_pocket_d = 23;
nut_pocket_depth = 8;
mount_pitch = 36;
mount_d = 4.3;

module mount_hole(x, y) {
    translate([x, y, -body_t / 2 - eps]) cylinder(d = mount_d, h = body_t + 2 * eps);
}

difference() {
    cube([body_l, body_w, body_t], center = true);
    translate([0, 0, body_t / 2 - nut_pocket_depth - eps])
        cylinder(d = nut_pocket_d, h = nut_pocket_depth + 2 * eps);
    for (x = [-mount_pitch / 2, mount_pitch / 2], y = [-12, 12]) mount_hole(x, y);
}
