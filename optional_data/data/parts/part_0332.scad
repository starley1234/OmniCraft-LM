// Hex standoff, 6 mm long.
$fn = 60;
eps = 0.02;
thread_d = 2.4;
flat = 5.5;
length = 6;
chamfer = 1.2;
difference() {
    union() {
        cylinder(d = flat / cos(30), h = length, $fn = 6);
        cylinder(d1 = flat / cos(30) - 2 * chamfer, d2 = flat / cos(30), h = chamfer, $fn = 6);
        translate([0, 0, length - chamfer]) cylinder(d1 = flat / cos(30), d2 = flat / cos(30) - 2 * chamfer, h = chamfer, $fn = 6);
    }
    translate([0, 0, -eps]) cylinder(d = thread_d, h = length + 2 * eps);
}
