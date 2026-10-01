$fn = 32;

// ----------------------------------------------------------------------
// Star wheel: 6-point star, R30
// ----------------------------------------------------------------------

// --- parameters (mm) ---
n_points = 6;             // number of points / teeth
r_out = 30;               // tip radius
r_in = 18;                // root radius
bore_r = 5;               // centre bore radius
plate_t = 5;              // plate thickness, Z (extrusion height)
bore_d = 10;              // centre bore diameter

profile = [[25.981, 60], [16.981, 45.588], [0, 45], [7.981, 30], [0, 15], [16.981, 14.412], [25.981, 0], [34.981, 14.412], [51.962, 15], [43.981, 30], [51.962, 45], [34.981, 45.588]];  // primary outline, 12 points, counter clockwise
void_1 = [[30.889, 30.954], [30.267, 32.575], [29.127, 33.886], [27.609, 34.728], [25.894, 34.999], [24.189, 34.668], [22.7, 33.774], [21.608, 32.424], [21.042, 30.782], [21.073, 29.046], [21.695, 27.425], [22.834, 26.114], [24.353, 25.272], [26.068, 25.001], [27.773, 25.332], [29.261, 26.226], [30.354, 27.576], [30.919, 29.218]];  // centre bore, 18 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
