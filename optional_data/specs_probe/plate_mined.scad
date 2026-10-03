$fn = 32;
// ----------------------------------------------------------------------
// Freeform cube: 120 x 80 x 8 mm
// ----------------------------------------------------------------------
// --- parameters (mm) ---
base_len = 120;           // base length, X
base_w = 80;              // base width, Y
base_h = 8;               // base height, Z
top_len = 100;            // top length, X
top_w = 32;               // top width, Y
top_h = 16;               // top height, Z
module base_profile() path {
  polygon(points = [[0, 0], [base_len, 0], [0, base_w]]);
}
module top_profile() path {
  translate([base_len / 2, 0, base_h])
    polygon(points = [[0, 0], [top_len, 0], [0, top_w]]);
}
module body() extrude() {
  union() {
    base_profile();
    top_profile();
  }
}
