// Wing nut with two reinforced wings.
$fn = 60;
eps = 0.02;
thread_d = 2.4;
body_d = 7;
body_h = 6;
wing_l = 8;
wing_t = 3;
difference() {
    union() {
        cylinder(d = body_d, h = body_h, $fn = 6);
        translate([body_d / 2 - 1, -wing_t / 2, body_h / 2 - wing_t / 2]) cube([wing_l, wing_t, wing_t]);
        translate([-body_d / 2 - wing_l + 1, -wing_t / 2, body_h / 2 - wing_t / 2]) cube([wing_l, wing_t, wing_t]);
    }
    translate([0, 0, -eps]) cylinder(d = thread_d, h = body_h + 2 * eps);
}
