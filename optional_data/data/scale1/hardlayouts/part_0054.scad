$fn = 32;

// ----------------------------------------------------------------------
// Hole field: plate with holes at given coordinates
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 80;             // plate length, X
plate_w = 80;             // plate width, Y
plate_t = 6;              // plate thickness, Z
hole_d = 6;               // hole diameter

difference() {
  cube([plate_l, plate_w, plate_t]);
  translate([15, 45, -1]) cylinder(h = plate_t + 2, d = hole_d);
  translate([25, 15, -1]) cylinder(h = plate_t + 2, d = hole_d);
  translate([45, 65, -1]) cylinder(h = plate_t + 2, d = hole_d);
  translate([55, 55, -1]) cylinder(h = plate_t + 2, d = hole_d);
}
