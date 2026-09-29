// NEMA 17 adjustable motor plate, 96 mm square.
$fn = 60;
eps = 0.02;
plate = 96;
plate_t = 8;
hole_pitch = 31;
center_d = 23;
slot_l = 24;
slot_d = 4.2;
module slot(x) {
    hull() {
        translate([x, -slot_l / 2, -plate_t / 2 - eps]) cylinder(d = slot_d, h = plate_t + 2 * eps);
        translate([x, slot_l / 2, -plate_t / 2 - eps]) cylinder(d = slot_d, h = plate_t + 2 * eps);
    }
}
difference() {
    cube([plate, plate, plate_t], center = true);
    translate([0, 0, -plate_t / 2 - eps]) cylinder(d = center_d, h = plate_t + 2 * eps);
    slot(-hole_pitch / 2);
    slot(hole_pitch / 2);
}
