$fn = 32;

// ----------------------------------------------------------------------
// Star wheel: 6-point star, R45
// ----------------------------------------------------------------------

// --- parameters (mm) ---
n_points = 6;             // number of points / teeth
r_out = 45;               // tip radius
r_in = 22.5;              // root radius
bore_r = 5;               // centre bore radius
plate_t = 8;              // plate thickness, Z (extrusion height)
bore_d = 10;              // centre bore diameter

profile = [[38.971, 90], [27.721, 64.486], [0, 67.5], [16.471, 45], [0, 22.5], [27.721, 25.514], [38.971, 0], [50.221, 25.514], [77.942, 22.5], [61.471, 45], [77.942, 67.5], [50.221, 64.486]];  // primary outline, 12 points, counter clockwise
void_1 = [[43.879, 45.954], [43.257, 47.575], [42.118, 48.886], [40.599, 49.728], [38.884, 49.999], [37.179, 49.668], [35.691, 48.774], [34.598, 47.424], [34.033, 45.782], [34.063, 44.046], [34.685, 42.425], [35.825, 41.114], [37.343, 40.272], [39.058, 40.001], [40.763, 40.332], [42.251, 41.226], [43.344, 42.576], [43.91, 44.218]];  // centre bore, 18 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
