$fn = 32;

// ----------------------------------------------------------------------
// Hole field: plate with holes at given coordinates
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 90;             // plate length, X
plate_w = 80;             // plate width, Y
plate_t = 6;              // plate thickness, Z
hole_d = 5;               // hole diameter
fit_tol = 0.05;           // tolerance for press fits, mm
free_tol = 0.2;           // tolerance for clearance fits, mm

difference() {
  cube([plate_l, plate_w, plate_t]);
  translate([15, 25, -1]) cylinder(h = plate_t + 2, d = hole_d);
  translate([15, 35, -1]) cylinder(h = plate_t + 2, d = hole_d);
  translate([55, 35, -1]) cylinder(h = plate_t + 2, d = hole_d);
  translate([75, 35, -1]) cylinder(h = plate_t + 2, d = hole_d);
}
