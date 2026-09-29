$fn = 32;

// ----------------------------------------------------------------------
// Cable clip: cable 6 mm, clamp 12 mm, base 28 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_x = 28;             // base length, X
plate_y = 16;             // base width, Y
plate_t = 6;              // base thickness
wire_seat_d = 12;         // clamp outside diameter
clip_t = 3;               // clamp wall
cable_d = 6;              // cable opening
ring_w = 10;              // clamp width along the cable
screw_d = 3.4;            // screw clearance
throat = 4.2;             // snap throat width
sink = 1;                 // overlap of the clamp into the base

module base() {
  cube([plate_x, plate_y, plate_t]);
}

module clamp() {
  translate([plate_x / 2, plate_y / 2, plate_t + wire_seat_d / 2 - sink]) rotate([0, 90, 0])
    cylinder(h = ring_w, d = wire_seat_d, center = true);
}

difference() {
  union() {
    base();
    clamp();
  }
  translate([plate_x / 2, plate_y / 2, plate_t + wire_seat_d / 2 - sink]) rotate([0, 90, 0]) translate([0, 0, -ring_w / 2 - 1]) cylinder(h = ring_w + 2, d = cable_d);
  /* snap throat: the opening is narrower than the cable */
  translate([plate_x / 2 - throat / 2, plate_y / 2, plate_t + wire_seat_d / 2 - sink]) rotate([0, 90, 0]) translate([0, 0, -ring_w / 2 - 1]) cube([throat, wire_seat_d + 2, ring_w + 2]);
  translate([7, plate_y / 2, -1]) cylinder(h = plate_t + 2, d = screw_d);
  translate([21, plate_y / 2, -1]) cylinder(h = plate_t + 2, d = screw_d);
}
