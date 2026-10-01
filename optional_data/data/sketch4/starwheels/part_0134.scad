$fn = 32;

// ----------------------------------------------------------------------
// Star wheel: 8-point star, R40
// ----------------------------------------------------------------------

// --- parameters (mm) ---
n_points = 8;             // number of points / teeth
r_out = 40;               // tip radius
r_in = 24;                // root radius
bore_r = 5;               // centre bore radius
plate_t = 6;              // plate thickness, Z (extrusion height)
bore_d = 10;              // centre bore diameter

profile = [[0, 40], [17.827, 30.816], [11.716, 11.716], [30.816, 17.827], [40, 0], [49.184, 17.827], [68.284, 11.716], [62.173, 30.816], [80, 40], [62.173, 49.184], [68.284, 68.284], [49.184, 62.173], [40, 80], [30.816, 62.173], [11.716, 68.284], [17.827, 49.184]];  // primary outline, 16 points, counter clockwise
void_1 = [[44.908, 40.954], [44.286, 42.575], [43.147, 43.886], [41.628, 44.728], [39.913, 44.999], [38.208, 44.668], [36.72, 43.774], [35.627, 42.424], [35.062, 40.782], [35.092, 39.046], [35.714, 37.425], [36.853, 36.114], [38.372, 35.272], [40.087, 35.001], [41.792, 35.332], [43.28, 36.226], [44.373, 37.576], [44.938, 39.218]];  // centre bore, 18 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
