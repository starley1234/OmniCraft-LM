$fn = 32;

// ----------------------------------------------------------------------
// Star wheel: 6-point star, R45
// ----------------------------------------------------------------------

// --- parameters (mm) ---
n_points = 6;             // number of points / teeth
r_out = 45;               // tip radius
r_in = 24.75;             // root radius
bore_r = 5;               // centre bore radius
plate_t = 8;              // plate thickness, Z (extrusion height)
bore_d = 10;              // centre bore diameter
fit_tol = 0.1;            // declared fit tolerance (prompt contract)
free_tol = 0.5;           // declared free tolerance (prompt contract)

profile = [[38.971, 90], [26.596, 66.434], [0, 67.5], [14.221, 45], [0, 22.5], [26.596, 23.566], [38.971, 0], [51.346, 23.566], [77.942, 22.5], [63.721, 45], [77.942, 67.5], [51.346, 66.434]];  // primary outline, 12 points, counter clockwise
void_1 = [[43.879, 45.954], [43.257, 47.575], [42.118, 48.886], [40.599, 49.728], [38.884, 49.999], [37.179, 49.668], [35.691, 48.774], [34.598, 47.424], [34.033, 45.782], [34.063, 44.046], [34.685, 42.425], [35.825, 41.114], [37.343, 40.272], [39.058, 40.001], [40.763, 40.332], [42.251, 41.226], [43.344, 42.576], [43.91, 44.218]];  // centre bore, 18 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
