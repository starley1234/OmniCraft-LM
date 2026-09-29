// GT2 pulley, 22 teeth for 9 mm belt.
$fn = 60;
eps = 0.02;
teeth = 22;
belt_pitch = 2;
belt_w = 9;
shaft_d = 5;
set_screw_d = 3.3;
tooth_depth = 0.75;
tooth_overlap = 0.28;
tooth_base_w = 1.2;
tooth_tip_w = 0.72;
flange_t = 1.6;
core_d = teeth * belt_pitch / PI - 1.0;
body_h = belt_w + 2 * flange_t;
module tooth() {
    linear_extrude(height = belt_w)
        polygon(points = [[-tooth_overlap, -tooth_base_w / 2], [tooth_depth, -tooth_tip_w / 2], [tooth_depth, tooth_tip_w / 2], [-tooth_overlap, tooth_base_w / 2]]);
}
difference() {
    union() {
        cylinder(d = core_d, h = body_h);
        cylinder(d = core_d + 4.8, h = flange_t);
        translate([0, 0, body_h - flange_t]) cylinder(d = core_d + 4.8, h = flange_t);
        for (i = [0 : teeth - 1]) rotate([0, 0, i * 360 / teeth]) translate([core_d / 2, 0, flange_t]) tooth();
    }
    translate([0, 0, -eps]) cylinder(d = shaft_d, h = body_h + 2 * eps);
    translate([-core_d / 2 - eps, 0, body_h / 2]) rotate([0, 90, 0]) cylinder(d = set_screw_d, h = core_d / 2 + 2 * eps);
}
