// Slotted spring pin sleeve.
$fn = 60;
eps = 0.02;
inner_d = 4;
outer_d = 8;
length = 24;
slot_w = 1.2;
difference() {
    cylinder(d = outer_d, h = length);
    translate([0, 0, -eps]) cylinder(d = inner_d, h = length + 2 * eps);
    translate([0, -slot_w / 2, -eps]) cube([outer_d / 2 + eps, slot_w, length + 2 * eps]);
}
