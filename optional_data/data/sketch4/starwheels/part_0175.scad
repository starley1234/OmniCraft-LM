$fn = 32;

// ----------------------------------------------------------------------
// Star wheel: 6-point star, R35
// ----------------------------------------------------------------------

// --- parameters (mm) ---
n_points = 6;             // number of points / teeth
r_out = 35;               // tip radius
r_in = 17.5;              // root radius
bore_r = 5;               // centre bore radius
plate_t = 8;              // plate thickness, Z (extrusion height)
bore_d = 10;              // centre bore diameter

profile = [[30.311, 70], [21.561, 50.155], [0, 52.5], [12.811, 35], [0, 17.5], [21.561, 19.845], [30.311, 0], [39.061, 19.845], [60.622, 17.5], [47.811, 35], [60.622, 52.5], [39.061, 50.155]];  // primary outline, 12 points, counter clockwise
void_1 = [[35.219, 35.954], [34.597, 37.575], [33.457, 38.886], [31.939, 39.728], [30.224, 39.999], [28.519, 39.668], [27.031, 38.774], [25.938, 37.424], [25.372, 35.782], [25.403, 34.046], [26.025, 32.425], [27.164, 31.114], [28.683, 30.272], [30.398, 30.001], [32.103, 30.332], [33.591, 31.226], [34.684, 32.576], [35.249, 34.218]];  // centre bore, 18 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
