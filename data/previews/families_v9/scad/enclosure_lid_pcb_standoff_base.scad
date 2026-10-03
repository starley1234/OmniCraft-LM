$fn = 32;
// Enclosure base with four PCB standoffs.

width = 65;
depth = 75;
base_t = 3;
post_h = 11;
post_d = 7.5;
post_bore = 3.2;
pcb_x = 41;
pcb_y = 55;

union() {
    difference() {
        cube([width, depth, base_t]);
        for (x = [5, width - 5], y = [5, depth - 5])
            translate([x, y, -1]) cylinder(h = base_t + 2, d = 3.2);
    }
    for (dx = [-pcb_x / 2, pcb_x / 2], dy = [-pcb_y / 2, pcb_y / 2])
        translate([width / 2 + dx, depth / 2 + dy, base_t])
            difference() {
                cylinder(h = post_h, d = post_d);
                translate([0, 0, -1])
                    cylinder(h = post_h + 2, d = post_bore);
            }
}
