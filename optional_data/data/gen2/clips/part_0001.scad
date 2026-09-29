$fn = 32;

// ----------------------------------------------------------------------
// Cable clip: cable 4 mm, clamp 9 mm, base 25 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_x = 25;             // base length, X
plate_y = 13;             // base width, Y
plate_t = 6;              // base thickness
wire_seat_d = 9;          // clamp outside diameter
clip_t = 2.5;             // clamp wall
cable_d = 4;              // cable opening
ring_w = 8;               // clamp width along the cable
screw_d = 3.4;            // screw clearance
throat = 3.12;            // snap throat width
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
  translate([6.25, plate_y / 2, -1]) cylinder(h = plate_t + 2, d = screw_d);
  translate([18.75, plate_y / 2, -1]) cylinder(h = plate_t + 2, d = screw_d);
}
