// Chamfered metric washer.
$fn = 60;
eps = 0.02;
inner_d = 26;
outer_d = 48;
thickness = 4;
chamfer = 0.6;
difference() {
    union() {
        cylinder(d1 = outer_d - 2 * chamfer, d2 = outer_d, h = chamfer);
        translate([0, 0, chamfer]) cylinder(d = outer_d, h = thickness - 2 * chamfer);
        translate([0, 0, thickness - chamfer]) cylinder(d1 = outer_d, d2 = outer_d - 2 * chamfer, h = chamfer);
    }
    translate([0, 0, -eps]) cylinder(d = inner_d, h = thickness + 2 * eps);
}
