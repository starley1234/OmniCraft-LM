$fn = 32;
// Vented cover with a row of through slots.

width = 105;
depth = 75;
thickness = 3;
slot_w = 3;
slot_n = 7;
margin = 10;
pitch = (width - 2 * margin - slot_w) / (slot_n - 1);

difference() {
    cube([width, depth, thickness]);
    for (i = [0 : slot_n - 1])
        hull() {
            translate([margin + i * pitch + slot_w / 2, margin + slot_w / 2, -1])
                cylinder(h = thickness + 2, d = slot_w);
            translate([margin + i * pitch + slot_w / 2, depth - margin - slot_w / 2, -1])
                cylinder(h = thickness + 2, d = slot_w);
        }
    for (x = [margin / 2, width - margin / 2], y = [margin / 2, depth - margin / 2])
        translate([x, y, -1]) cylinder(h = thickness + 2, d = 3.2);
}
