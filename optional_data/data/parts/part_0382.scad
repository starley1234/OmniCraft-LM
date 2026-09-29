// Through hex nut.
$fn = 60;
eps = 0.02;
thread_clearance_d = 8.4;
flat = 13;
thickness = 6.5;
chamfer = 0.5;
difference() {
    union() {
        cylinder(d1 = flat / cos(30) - 2 * chamfer, d2 = flat / cos(30), h = chamfer, $fn = 6);
        translate([0, 0, chamfer]) cylinder(d = flat / cos(30), h = thickness - 2 * chamfer, $fn = 6);
        translate([0, 0, thickness - chamfer]) cylinder(d1 = flat / cos(30), d2 = flat / cos(30) - 2 * chamfer, h = chamfer, $fn = 6);
    }
    translate([0, 0, -eps]) cylinder(d = thread_clearance_d, h = thickness + 2 * eps);
}
