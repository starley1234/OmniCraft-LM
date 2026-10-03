$fn = 32;
// target_bbox: 240, 170, 5
// ----------------------------------------------------------------------
// Big plate: 200-250 mm adapter plate
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 240;            // plate length, X
plate_w = 170;            // plate width, Y
plate_t = 5;              // plate thickness, Z
corner_d = 8;             // corner hole diameter
corner_in = 15;           // corner hole inset from the edges
bore_d = 30;              // central bore
fit_tol = 0.1;            // tolerance for press fits, mm
free_tol = 0.3;           // tolerance for clearance fits, mm

difference() {
  cube([plate_l, plate_w, plate_t]);
  translate([corner_in, corner_in, -1]) cylinder(h = plate_t + 2, d = corner_d);
  translate([plate_l - corner_in, corner_in, -1]) cylinder(h = plate_t + 2, d = corner_d);
  translate([corner_in, plate_w - corner_in, -1]) cylinder(h = plate_t + 2, d = corner_d);
  translate([plate_l - corner_in, plate_w - corner_in, -1]) cylinder(h = plate_t + 2, d = corner_d);
  translate([plate_l / 2, plate_w / 2, -1]) cylinder(h = plate_t + 2, d = bore_d);
}
