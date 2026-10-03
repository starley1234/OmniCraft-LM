$fn = 32;
// Chamfered mounting plate 75x40x10 mm.

width = 75;
depth = 40;
thickness = 10;
chamfer = 1.5;
hole_d = 5.2;
inset = 8;

difference() {
    hull() {
        translate([chamfer, chamfer, 0])
            cube([width - 2 * chamfer, depth - 2 * chamfer, thickness]);
        translate([0, 0, chamfer])
            cube([width, depth, thickness - 2 * chamfer]);
    }
    for (x = [inset, width - inset], y = [inset, depth - inset])
        translate([x, y, -1]) cylinder(h = thickness + 2, d = hole_d);
}
