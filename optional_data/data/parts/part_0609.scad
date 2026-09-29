// Flat-eye bolt with a smooth shaft.
$fn = 60;
eps = 0.02;
shaft_d = 4;
shaft_l = 14;
eye_outer_d = 16;
eye_inner_d = eye_outer_d - 2 * 5;
eye_t = 5;
module eye() {
    translate([0, -eye_t / 2, shaft_l + eye_outer_d / 2 - 1]) rotate([-90, 0, 0])
        difference() { cylinder(d = eye_outer_d, h = eye_t); translate([0, 0, -eps]) cylinder(d = eye_inner_d, h = eye_t + 2 * eps); }
}
union() { cylinder(d = shaft_d, h = shaft_l + 2); eye(); }
