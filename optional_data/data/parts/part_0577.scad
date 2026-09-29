// Square nut.
$fn = 60;
eps = 0.02;
thread_d = 21;
side = 30;
thickness = 15;
difference() {
    cube([side, side, thickness], center = true);
    translate([0, 0, -thickness / 2 - eps]) cylinder(d = thread_d, h = thickness + 2 * eps);
}
