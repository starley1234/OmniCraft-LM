$fn = 32;
// Conical pipe reducer 42 mm to 18 mm.

large_d = 42;
small_d = 18;
wall = 2.5;
cone_l = 28;
collar_a = 16;
collar_b = 16;

difference() {
    union() {
        cylinder(h = collar_a, d = large_d);
        translate([0, 0, collar_a])
            cylinder(h = cone_l, d1 = large_d, d2 = small_d);
        translate([0, 0, collar_a + cone_l])
            cylinder(h = collar_b, d = small_d);
    }
    translate([0, 0, -1])
        cylinder(h = collar_a + 1, d = large_d - 2 * wall);
    translate([0, 0, collar_a])
        cylinder(h = cone_l, d1 = large_d - 2 * wall, d2 = small_d - 2 * wall);
    translate([0, 0, collar_a + cone_l])
        cylinder(h = collar_b + 1, d = small_d - 2 * wall);
}
