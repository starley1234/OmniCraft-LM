// Plain sleeve bushing.
$fn = 60;
eps = 0.02;
inner_d = 20;
outer_d = 28;
length = 28;
chamfer = 0.6;
difference() {
    union() {
        cylinder(d1 = outer_d - 2 * chamfer, d2 = outer_d, h = chamfer);
        translate([0, 0, chamfer]) cylinder(d = outer_d, h = length - 2 * chamfer);
        translate([0, 0, length - chamfer]) cylinder(d1 = outer_d, d2 = outer_d - 2 * chamfer, h = chamfer);
    }
    translate([0, 0, -eps]) cylinder(d = inner_d, h = length + 2 * eps);
}
