// M5 standoff 20 mm: hex-bodied through standoff.
$fn = 60;
eps = 0.02;
thread_clearance_d = 5.4;
outer_flat = 10;
length = 20;
chamfer = 1.2;

difference() {
    union() {
        cylinder(d = outer_flat / cos(30), h = length, $fn = 6);
        cylinder(d1 = outer_flat / cos(30) - 2 * chamfer, d2 = outer_flat / cos(30), h = chamfer, $fn = 6);
        translate([0, 0, length - chamfer])
            cylinder(d1 = outer_flat / cos(30), d2 = outer_flat / cos(30) - 2 * chamfer, h = chamfer, $fn = 6);
    }
    translate([0, 0, -eps]) cylinder(d = thread_clearance_d, h = length + 2 * eps);
}
