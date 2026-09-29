// Cable strain-relief clamp for 9 mm bundle.
$fn = 60;
eps = 0.02;
body_l = 48;
body_w = 27;
body_h = 17;
cable_d = 9.5;
bolt_pitch = 32;
difference() {
    cube([body_l, body_w, body_h], center = true);
    translate([0, -body_w / 2 - eps, 0]) rotate([-90, 0, 0]) cylinder(d = cable_d, h = body_w + 2 * eps);
    for (x = [-bolt_pitch / 2, bolt_pitch / 2]) {
        translate([x, 0, -body_h / 2 - eps]) cylinder(d = 3.4, h = body_h + 2 * eps);
        translate([x, 0, body_h / 2 - 3]) cylinder(d = 6.4, h = 3 + eps, $fn = 6);
    }
}
