$fn = 32;

// ----------------------------------------------------------------------
// Cable clip: cable 12 mm, clamp 20 mm, base 52 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_x = 52;             // base length, X
plate_y = 28;             // base width, Y
plate_t = 6;              // base thickness
wire_seat_d = 20;         // clamp outside diameter
clip_t = 4;               // clamp wall
cable_d = 12;             // cable opening
ring_w = 6;               // clamp width along the cable
screw_d = 5.5;            // screw clearance
sink = 1;                 // overlap of the clamp into the base
pitch = 26;               // distance between the two clamps

module base() {
  cube([plate_x, plate_y, plate_t]);
}

module clamps() {
  for (sx = [-1, 1])
    translate([plate_x / 2 + sx * pitch / 2, plate_y / 2, plate_t + wire_seat_d / 2 - sink]) rotate([0, 90, 0])
      cylinder(h = ring_w, d = wire_seat_d, center = true);
}

difference() {
  union() {
    base();
    clamps();
  }
  for (sx = [-1, 1])
    translate([plate_x / 2 + sx * pitch / 2, plate_y / 2, plate_t + wire_seat_d / 2 - sink]) rotate([0, 90, 0]) translate([0, 0, -ring_w / 2 - 1]) cylinder(h = ring_w + 2, d = cable_d);
  translate([13, plate_y / 2, -1]) cylinder(h = plate_t + 2, d = screw_d);
  translate([39, plate_y / 2, -1]) cylinder(h = plate_t + 2, d = screw_d);
}
