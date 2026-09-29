// Cable gland body for 14 mm cable.
$fn = 60;
eps = 0.02;
cable_d = 14;
body_d = 32;
body_l = 18;
flange_d = body_d + 8;
flange_t = 3;
difference() {
    union() { cylinder(d = flange_d, h = flange_t); cylinder(d = body_d, h = body_l); }
    translate([0, 0, -eps]) cylinder(d = cable_d + 0.5, h = body_l + 2 * eps);
}
