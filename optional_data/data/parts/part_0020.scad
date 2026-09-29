// Split coupling 5x8 compact
// One-piece split coupling for 5 mm and 8 mm shafts; clamp slots are fully through-cut.
$fn = 60;
eps = 0.02;
shaft_a_d = 5;
shaft_b_d = 8;
outer_d = 20;
length = 30;
slot_w = 1.8;
clamp_screw_d = 3.4;
head_recess_d = 6.6;
head_recess_depth = 3;

module clamp_screw(z_pos) {
    translate([outer_d / 2 - 3.5, -outer_d / 2 - eps, z_pos])
        rotate([-90, 0, 0]) cylinder(d = clamp_screw_d, h = outer_d + 2 * eps);
    translate([outer_d / 2 - 3.5, outer_d / 2 - head_recess_depth, z_pos])
        rotate([-90, 0, 0]) cylinder(d = head_recess_d, h = head_recess_depth + eps);
}

difference() {
    cylinder(d = outer_d, h = length);
    translate([0, 0, -eps]) cylinder(d = shaft_a_d, h = length / 2 + eps);
    translate([0, 0, length / 2 - eps]) cylinder(d = shaft_b_d, h = length / 2 + eps);
    translate([0, -slot_w / 2, -eps]) cube([outer_d / 2 + eps, slot_w, length + 2 * eps]);
    clamp_screw(length / 4);
    clamp_screw(3 * length / 4);
}
