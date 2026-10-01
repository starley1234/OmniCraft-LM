$fn = 32;

// ----------------------------------------------------------------------
// Hole field: plate with holes at given coordinates
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 80;             // plate length, X
plate_w = 80;             // plate width, Y
plate_t = 5;              // plate thickness, Z
hole_d = 6;               // hole diameter
fit_tol = 0.05;           // tolerance for press fits, mm
free_tol = 0.3;           // tolerance for clearance fits, mm

difference() {
  cube([plate_l, plate_w, plate_t]);
  translate([25, 35, -1]) cylinder(h = plate_t + 2, d = hole_d);
  translate([35, 55, -1]) cylinder(h = plate_t + 2, d = hole_d);
  translate([45, 35, -1]) cylinder(h = plate_t + 2, d = hole_d);
  translate([65, 35, -1]) cylinder(h = plate_t + 2, d = hole_d);
  translate([65, 65, -1]) cylinder(h = plate_t + 2, d = hole_d);
}
