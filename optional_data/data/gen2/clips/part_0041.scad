$fn = 32;

// ----------------------------------------------------------------------
// Cable clip: cable 8 mm, clamp 12 mm, base 36 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_x = 36;             // base length, X
plate_y = 20;             // base width, Y
plate_t = 6;              // base thickness
wire_seat_d = 12;         // clamp outside diameter
clip_t = 2;               // clamp wall
cable_d = 8;              // cable opening
ring_w = 6;               // clamp width along the cable
screw_d = 5.5;            // screw clearance
sink = 1;                 // overlap of the clamp into the base
pitch = 18;               // distance between the two clamps

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
  translate([9, plate_y / 2, -1]) cylinder(h = plate_t + 2, d = screw_d);
  translate([27, plate_y / 2, -1]) cylinder(h = plate_t + 2, d = screw_d);
}
