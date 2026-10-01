$fn = 32;

// ----------------------------------------------------------------------
// Star wheel: 6-point blunt, R35
// ----------------------------------------------------------------------

// --- parameters (mm) ---
n_points = 6;             // number of points / teeth
r_out = 35;               // tip radius
r_in = 24.5;              // root radius
bore_r = 5;               // centre bore radius
plate_t = 8;              // plate thickness, Z (extrusion height)
bore_d = 10;              // centre bore diameter

profile = [[70, 30.311], [56.218, 42.561], [52.5, 60.622], [35, 54.811], [17.5, 60.622], [13.782, 42.561], [0, 30.311], [13.782, 18.061], [17.5, 0], [35, 5.811], [52.5, 0], [56.218, 18.061]];  // primary outline, 12 points, counter clockwise
void_1 = [[39.908, 31.265], [39.286, 32.886], [38.147, 34.197], [36.628, 35.038], [34.913, 35.31], [33.208, 34.979], [31.72, 34.084], [30.627, 32.735], [30.062, 31.093], [30.092, 29.357], [30.714, 27.736], [31.853, 26.425], [33.372, 25.583], [35.087, 25.312], [36.792, 25.643], [38.28, 26.537], [39.373, 27.887], [39.938, 29.529]];  // centre bore, 18 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
