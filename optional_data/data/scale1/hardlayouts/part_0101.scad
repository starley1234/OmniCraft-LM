$fn = 32;

// ----------------------------------------------------------------------
// Hole field: plate with holes at given coordinates
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 110;            // plate length, X
plate_w = 70;             // plate width, Y
plate_t = 5;              // plate thickness, Z
hole_d = 6;               // hole diameter

difference() {
  cube([plate_l, plate_w, plate_t]);
  translate([25, 35, -1]) cylinder(h = plate_t + 2, d = hole_d);
  translate([35, 35, -1]) cylinder(h = plate_t + 2, d = hole_d);
  translate([45, 45, -1]) cylinder(h = plate_t + 2, d = hole_d);
  translate([85, 25, -1]) cylinder(h = plate_t + 2, d = hole_d);
  translate([95, 35, -1]) cylinder(h = plate_t + 2, d = hole_d);
  translate([95, 55, -1]) cylinder(h = plate_t + 2, d = hole_d);
}
