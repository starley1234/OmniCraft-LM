$fn = 32;

// ----------------------------------------------------------------------
// Hole field: plate with holes at given coordinates
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 120;            // plate length, X
plate_w = 80;             // plate width, Y
plate_t = 6;              // plate thickness, Z
hole_d = 8;               // hole diameter

difference() {
  cube([plate_l, plate_w, plate_t]);
  translate([35, 65, -1]) cylinder(h = plate_t + 2, d = hole_d);
  translate([45, 55, -1]) cylinder(h = plate_t + 2, d = hole_d);
  translate([75, 35, -1]) cylinder(h = plate_t + 2, d = hole_d);
  translate([75, 55, -1]) cylinder(h = plate_t + 2, d = hole_d);
}
