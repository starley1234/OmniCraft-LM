// Square nut.
$fn = 60;
eps = 0.02;
thread_d = 6.4;
side = 12;
thickness = 5;
difference() {
    cube([side, side, thickness], center = true);
    translate([0, 0, -thickness / 2 - eps]) cylinder(d = thread_d, h = thickness + 2 * eps);
}
