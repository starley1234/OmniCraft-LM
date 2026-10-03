$fn = 32;
// Split shaft coupler 5 mm to 8 mm.

bore_a = 5;
bore_b = 8;
length = 36;
outer_d = 18;
slot_w = 1.6;

difference() {
    cylinder(h = length, d = outer_d);
    translate([0, 0, -1]) cylinder(h = length / 2 + 1, d = bore_a);
    translate([0, 0, length / 2]) cylinder(h = length / 2 + 1, d = bore_b);
    translate([-outer_d / 2 - 1, -slot_w / 2, length * 0.08])
        cube([outer_d + 2, slot_w, length * 0.34]);
    translate([-outer_d / 2 - 1, -slot_w / 2, length * 0.58])
        cube([outer_d + 2, slot_w, length * 0.34]);
    for (z = [length * 0.25, length * 0.75])
        translate([0, outer_d / 2 + 1, z]) rotate([90, 0, 0])
            cylinder(h = outer_d + 2, d = 3.2);
}
