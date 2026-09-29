// 4-bolt mounting flange, 50 mm OD.
$fn = 60;
eps = 0.02;
flange_d = 50;
flange_t = 6;
hub_d = 26;
hub_h = 14;
center_d = 8;
bolt_circle_d = 36;
bolt_d = 4.3;
difference() {
    union() { cylinder(d = flange_d, h = flange_t); cylinder(d = hub_d, h = hub_h); }
    translate([0, 0, -eps]) cylinder(d = center_d, h = hub_h + 2 * eps);
    for (i = [0 : 3]) rotate([0, 0, i * 360 / 4])
        translate([bolt_circle_d / 2, 0, -eps]) cylinder(d = bolt_d, h = flange_t + 2 * eps);
}
