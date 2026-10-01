$fn = 32;

// ----------------------------------------------------------------------
// Hole field: plate with holes at given coordinates
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 90;             // plate length, X
plate_w = 60;             // plate width, Y
plate_t = 5;              // plate thickness, Z
hole_d = 8;               // hole diameter

difference() {
  cube([plate_l, plate_w, plate_t]);
  translate([15, 15, -1]) cylinder(h = plate_t + 2, d = hole_d);
  translate([15, 35, -1]) cylinder(h = plate_t + 2, d = hole_d);
  translate([25, 45, -1]) cylinder(h = plate_t + 2, d = hole_d);
  translate([45, 35, -1]) cylinder(h = plate_t + 2, d = hole_d);
  translate([75, 15, -1]) cylinder(h = plate_t + 2, d = hole_d);
  translate([75, 35, -1]) cylinder(h = plate_t + 2, d = hole_d);
}
