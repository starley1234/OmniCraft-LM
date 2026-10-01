$fn = 32;

// ----------------------------------------------------------------------
// Big plate: 200-250 mm adapter plate
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 240;            // plate length, X
plate_w = 170;            // plate width, Y
plate_t = 8;              // plate thickness, Z
corner_d = 8;             // corner hole diameter
corner_in = 20;           // corner hole inset from the edges
bore_d = 50;              // central bore

difference() {
  cube([plate_l, plate_w, plate_t]);
  translate([corner_in, corner_in, -1]) cylinder(h = plate_t + 2, d = corner_d);
  translate([plate_l - corner_in, corner_in, -1]) cylinder(h = plate_t + 2, d = corner_d);
  translate([corner_in, plate_w - corner_in, -1]) cylinder(h = plate_t + 2, d = corner_d);
  translate([plate_l - corner_in, plate_w - corner_in, -1]) cylinder(h = plate_t + 2, d = corner_d);
  translate([plate_l / 2, plate_w / 2, -1]) cylinder(h = plate_t + 2, d = bore_d);
}
