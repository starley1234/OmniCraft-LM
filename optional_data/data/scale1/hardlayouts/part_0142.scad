$fn = 32;

// ----------------------------------------------------------------------
// Hole field: plate with holes at given coordinates
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 80;             // plate length, X
plate_w = 60;             // plate width, Y
plate_t = 6;              // plate thickness, Z
hole_d = 5;               // hole diameter

difference() {
  cube([plate_l, plate_w, plate_t]);
  translate([15, 45, -1]) cylinder(h = plate_t + 2, d = hole_d);
  translate([25, 15, -1]) cylinder(h = plate_t + 2, d = hole_d);
  translate([35, 15, -1]) cylinder(h = plate_t + 2, d = hole_d);
  translate([35, 45, -1]) cylinder(h = plate_t + 2, d = hole_d);
  translate([55, 35, -1]) cylinder(h = plate_t + 2, d = hole_d);
}
