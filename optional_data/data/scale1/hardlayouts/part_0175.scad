$fn = 32;

// ----------------------------------------------------------------------
// Hole field: plate with holes at given coordinates
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 120;            // plate length, X
plate_w = 80;             // plate width, Y
plate_t = 5;              // plate thickness, Z
hole_d = 6;               // hole diameter

difference() {
  cube([plate_l, plate_w, plate_t]);
  translate([15, 55, -1]) cylinder(h = plate_t + 2, d = hole_d);
  translate([25, 45, -1]) cylinder(h = plate_t + 2, d = hole_d);
  translate([35, 25, -1]) cylinder(h = plate_t + 2, d = hole_d);
  translate([55, 45, -1]) cylinder(h = plate_t + 2, d = hole_d);
  translate([65, 55, -1]) cylinder(h = plate_t + 2, d = hole_d);
  translate([105, 25, -1]) cylinder(h = plate_t + 2, d = hole_d);
}
