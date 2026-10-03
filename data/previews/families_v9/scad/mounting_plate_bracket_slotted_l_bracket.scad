$fn = 32;
// Slotted L-bracket with adjustment slots on both legs.

width = 45;
depth = 30;
height = 45;
wall = 6;
slot_w = 5.2;
slot_l = 10;

difference() {
    union() {
        cube([width, depth, wall]);
        cube([width, wall, height]);
    }
    for (x = [width / 4, 3 * width / 4 - slot_l])
        hull() {
            translate([x, depth / 2 + wall / 2, -1])
                cylinder(h = wall + 2, d = slot_w);
            translate([x + slot_l, depth / 2 + wall / 2, -1])
                cylinder(h = wall + 2, d = slot_w);
        }
    for (x = [width / 4, 3 * width / 4 - slot_l])
        hull() {
            translate([x, -1, height / 2 + wall / 2]) rotate([-90, 0, 0])
                cylinder(h = wall + 2, d = slot_w);
            translate([x + slot_l, -1, height / 2 + wall / 2]) rotate([-90, 0, 0])
                cylinder(h = wall + 2, d = slot_w);
        }
}
