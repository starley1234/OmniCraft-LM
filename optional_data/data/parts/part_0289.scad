// Lead-screw nut holder with 18 mm pocket.
$fn = 60;
eps = 0.02;
body_l = 48;
body_w = 34;
body_t = 10;
pocket_d = 18;
pocket_depth = 6;
mount_x = 17.0;
difference() {
    cube([body_l, body_w, body_t], center = true);
    translate([0, 0, body_t / 2 - pocket_depth - eps]) cylinder(d = pocket_d, h = pocket_depth + 2 * eps);
    for (x = [-mount_x, mount_x], y = [-body_w / 4, body_w / 4])
        translate([x, y, -body_t / 2 - eps]) cylinder(d = 4.3, h = body_t + 2 * eps);
}
