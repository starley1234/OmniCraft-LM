$fn = 32;

// ----------------------------------------------------------------------
// Hole field: plate with holes at given coordinates
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 110;            // plate length, X
plate_w = 50;             // plate width, Y
plate_t = 5;              // plate thickness, Z
hole_d = 8;               // hole diameter

difference() {
  cube([plate_l, plate_w, plate_t]);
  translate([15, 15, -1]) cylinder(h = plate_t + 2, d = hole_d);
  translate([15, 35, -1]) cylinder(h = plate_t + 2, d = hole_d);
  translate([45, 15, -1]) cylinder(h = plate_t + 2, d = hole_d);
  translate([65, 35, -1]) cylinder(h = plate_t + 2, d = hole_d);
  translate([75, 25, -1]) cylinder(h = plate_t + 2, d = hole_d);
  translate([95, 35, -1]) cylinder(h = plate_t + 2, d = hole_d);
}
