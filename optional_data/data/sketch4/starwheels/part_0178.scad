$fn = 32;

// ----------------------------------------------------------------------
// Star wheel: 8-point blunt, R45
// ----------------------------------------------------------------------

// --- parameters (mm) ---
n_points = 8;             // number of points / teeth
r_out = 45;               // tip radius
r_in = 27;                // root radius
bore_r = 5;               // centre bore radius
plate_t = 8;              // plate thickness, Z (extrusion height)
bore_d = 10;              // centre bore diameter

profile = [[0, 45], [20.055, 34.668], [13.18, 13.18], [34.668, 20.055], [45, 0], [55.332, 20.055], [76.82, 13.18], [69.945, 34.668], [90, 45], [69.945, 55.332], [76.82, 76.82], [55.332, 69.945], [45, 90], [34.668, 69.945], [13.18, 76.82], [20.055, 55.332]];  // primary outline, 16 points, counter clockwise
void_1 = [[49.908, 45.954], [49.286, 47.575], [48.147, 48.886], [46.628, 49.728], [44.913, 49.999], [43.208, 49.668], [41.72, 48.774], [40.627, 47.424], [40.062, 45.782], [40.092, 44.046], [40.714, 42.425], [41.853, 41.114], [43.372, 40.272], [45.087, 40.001], [46.792, 40.332], [48.28, 41.226], [49.373, 42.576], [49.938, 44.218]];  // centre bore, 18 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
