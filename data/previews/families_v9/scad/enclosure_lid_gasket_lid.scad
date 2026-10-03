$fn = 32;
// Enclosure lid with a closed gasket groove.

width = 90;
depth = 65;
thickness = 5;
groove_w = 2;
groove_d = 2.5;
margin = 7;
hole_d = 3.2;

difference() {
    cube([width, depth, thickness]);
    difference() {
        translate([margin, margin, thickness - groove_d])
            cube([width - 2 * margin, depth - 2 * margin, groove_d + 1]);
        translate([margin + groove_w, margin + groove_w, thickness - groove_d - 1])
            cube([
                width - 2 * (margin + groove_w),
                depth - 2 * (margin + groove_w),
                groove_d + 3
            ]);
    }
    for (x = [margin / 2 + 1, width - margin / 2 - 1],
         y = [margin / 2 + 1, depth - margin / 2 - 1])
        translate([x, y, -1]) cylinder(h = thickness + 2, d = hole_d);
}
