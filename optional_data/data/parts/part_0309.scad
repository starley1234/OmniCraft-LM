// 8-bolt mounting flange, 82 mm OD.
$fn = 60;
eps = 0.02;
flange_d = 82;
flange_t = 6;
hub_d = 38;
hub_h = 14;
center_d = 20;
bolt_circle_d = 68;
bolt_d = 4.3;
difference() {
    union() { cylinder(d = flange_d, h = flange_t); cylinder(d = hub_d, h = hub_h); }
    translate([0, 0, -eps]) cylinder(d = center_d, h = hub_h + 2 * eps);
    for (i = [0 : 7]) rotate([0, 0, i * 360 / 8])
        translate([bolt_circle_d / 2, 0, -eps]) cylinder(d = bolt_d, h = flange_t + 2 * eps);
}
