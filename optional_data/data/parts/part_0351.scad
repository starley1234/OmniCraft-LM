// Motor adapter spacer with 50 mm mounting pitch.
$fn = 60;
eps = 0.02;
plate = 88;
plate_t = 6;
hole_pitch = 50;
center_d = 36;
module hole(x, y) {
    translate([x, y, -plate_t / 2 - eps]) cylinder(d = 3.6, h = plate_t + 2 * eps);
    translate([x, y, plate_t / 2 - 2.2]) cylinder(d = 7, h = 2.2 + eps);
}
difference() {
    cube([plate, plate, plate_t], center = true);
    translate([0, 0, -plate_t / 2 - eps]) cylinder(d = center_d, h = plate_t + 2 * eps);
    for (x = [-hole_pitch / 2, hole_pitch / 2], y = [-hole_pitch / 2, hole_pitch / 2]) hole(x, y);
}
