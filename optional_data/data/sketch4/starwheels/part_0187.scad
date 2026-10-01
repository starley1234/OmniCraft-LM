$fn = 32;

// ----------------------------------------------------------------------
// Star wheel: 8-point blunt, R40
// ----------------------------------------------------------------------

// --- parameters (mm) ---
n_points = 8;             // number of points / teeth
r_out = 40;               // tip radius
r_in = 28;                // root radius
bore_r = 5;               // centre bore radius
plate_t = 5;              // plate thickness, Z (extrusion height)
bore_d = 10;              // centre bore diameter

profile = [[0, 40], [14.131, 29.285], [11.716, 11.716], [29.285, 14.131], [40, 0], [50.715, 14.131], [68.284, 11.716], [65.869, 29.285], [80, 40], [65.869, 50.715], [68.284, 68.284], [50.715, 65.869], [40, 80], [29.285, 65.869], [11.716, 68.284], [14.131, 50.715]];  // primary outline, 16 points, counter clockwise
void_1 = [[44.908, 40.954], [44.286, 42.575], [43.147, 43.886], [41.628, 44.728], [39.913, 44.999], [38.208, 44.668], [36.72, 43.774], [35.627, 42.424], [35.062, 40.782], [35.092, 39.046], [35.714, 37.425], [36.853, 36.114], [38.372, 35.272], [40.087, 35.001], [41.792, 35.332], [43.28, 36.226], [44.373, 37.576], [44.938, 39.218]];  // centre bore, 18 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
