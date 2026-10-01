$fn = 32;

// ----------------------------------------------------------------------
// Hole field: plate with holes at given coordinates
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 100;            // plate length, X
plate_w = 80;             // plate width, Y
plate_t = 5;              // plate thickness, Z
hole_d = 8;               // hole diameter
fit_tol = 0.02;           // tolerance for press fits, mm
free_tol = 0.2;           // tolerance for clearance fits, mm

difference() {
  cube([plate_l, plate_w, plate_t]);
  translate([15, 35, -1]) cylinder(h = plate_t + 2, d = hole_d);
  translate([35, 45, -1]) cylinder(h = plate_t + 2, d = hole_d);
  translate([85, 25, -1]) cylinder(h = plate_t + 2, d = hole_d);
  translate([85, 35, -1]) cylinder(h = plate_t + 2, d = hole_d);
}
