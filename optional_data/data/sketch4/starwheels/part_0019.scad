$fn = 32;

// ----------------------------------------------------------------------
// Star wheel: 8-point blunt, R40
// ----------------------------------------------------------------------

// --- parameters (mm) ---
n_points = 8;             // number of points / teeth
r_out = 40;               // tip radius
r_in = 26;                // root radius
bore_r = 6;               // centre bore radius
plate_t = 8;              // plate thickness, Z (extrusion height)
bore_d = 12;              // centre bore diameter

profile = [[0, 40], [15.979, 30.05], [11.716, 11.716], [30.05, 15.979], [40, 0], [49.95, 15.979], [68.284, 11.716], [64.021, 30.05], [80, 40], [64.021, 49.95], [68.284, 68.284], [49.95, 64.021], [40, 80], [30.05, 64.021], [11.716, 68.284], [15.979, 49.95]];  // primary outline, 16 points, counter clockwise
void_1 = [[45.89, 41.145], [45.143, 43.09], [43.776, 44.663], [41.953, 45.673], [39.895, 45.999], [37.85, 45.601], [36.064, 44.528], [34.752, 42.909], [34.074, 40.939], [34.11, 38.855], [34.857, 36.91], [36.224, 35.337], [38.047, 34.327], [40.105, 34.001], [42.15, 34.399], [43.936, 35.472], [45.248, 37.091], [45.926, 39.061]];  // centre bore, 18 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
