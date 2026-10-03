$fn = 32;
// NEMA 17 motor mount plate.

size = 47;
thickness = 4;
spacing = 31;
bolt_d = 3.4;
pilot_d = 22.5;
radius = 6;

difference() {
    hull()
        for (x = [radius, size - radius], y = [radius, size - radius])
            translate([x, y, 0]) cylinder(h = thickness, r = radius);
    translate([size / 2, size / 2, -1])
        cylinder(h = thickness + 2, d = pilot_d);
    for (dx = [-spacing / 2, spacing / 2], dy = [-spacing / 2, spacing / 2])
        translate([size / 2 + dx, size / 2 + dy, -1])
            cylinder(h = thickness + 2, d = bolt_d);
}
