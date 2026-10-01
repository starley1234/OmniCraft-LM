$fn = 32;

// ----------------------------------------------------------------------
// Star wheel: 6-point star, R40
// ----------------------------------------------------------------------

// --- parameters (mm) ---
n_points = 6;             // number of points / teeth
r_out = 40;               // tip radius
r_in = 22;                // root radius
bore_r = 5;               // centre bore radius
plate_t = 6;              // plate thickness, Z (extrusion height)
bore_d = 10;              // centre bore diameter

profile = [[34.641, 80], [23.641, 59.053], [0, 60], [12.641, 40], [0, 20], [23.641, 20.947], [34.641, 0], [45.641, 20.947], [69.282, 20], [56.641, 40], [69.282, 60], [45.641, 59.053]];  // primary outline, 12 points, counter clockwise
void_1 = [[39.549, 40.954], [38.927, 42.575], [37.788, 43.886], [36.269, 44.728], [34.554, 44.999], [32.849, 44.668], [31.361, 43.774], [30.268, 42.424], [29.703, 40.782], [29.733, 39.046], [30.355, 37.425], [31.494, 36.114], [33.013, 35.272], [34.728, 35.001], [36.433, 35.332], [37.921, 36.226], [39.014, 37.576], [39.579, 39.218]];  // centre bore, 18 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
