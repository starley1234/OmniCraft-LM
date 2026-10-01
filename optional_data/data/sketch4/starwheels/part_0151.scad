$fn = 32;

// ----------------------------------------------------------------------
// Star wheel: 8-point star, R45
// ----------------------------------------------------------------------

// --- parameters (mm) ---
n_points = 8;             // number of points / teeth
r_out = 45;               // tip radius
r_in = 27;                // root radius
bore_r = 6;               // centre bore radius
plate_t = 8;              // plate thickness, Z (extrusion height)
bore_d = 12;              // centre bore diameter
fit_tol = 0.1;            // declared fit tolerance (prompt contract)
free_tol = 0.3;           // declared free tolerance (prompt contract)

profile = [[90, 45], [69.945, 55.332], [76.82, 76.82], [55.332, 69.945], [45, 90], [34.668, 69.945], [13.18, 76.82], [20.055, 55.332], [0, 45], [20.055, 34.668], [13.18, 13.18], [34.668, 20.055], [45, 0], [55.332, 20.055], [76.82, 13.18], [69.945, 34.668]];  // primary outline, 16 points, counter clockwise
void_1 = [[50.89, 46.145], [50.143, 48.09], [48.776, 49.663], [46.953, 50.673], [44.895, 50.999], [42.85, 50.601], [41.064, 49.528], [39.752, 47.909], [39.074, 45.939], [39.11, 43.855], [39.857, 41.91], [41.224, 40.337], [43.047, 39.327], [45.105, 39.001], [47.15, 39.399], [48.936, 40.472], [50.248, 42.091], [50.926, 44.061]];  // centre bore, 18 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
