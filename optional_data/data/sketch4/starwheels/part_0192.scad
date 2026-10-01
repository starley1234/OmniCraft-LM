$fn = 32;

// ----------------------------------------------------------------------
// Star wheel: 6-point blunt, R45
// ----------------------------------------------------------------------

// --- parameters (mm) ---
n_points = 6;             // number of points / teeth
r_out = 45;               // tip radius
r_in = 31.5;              // root radius
bore_r = 6;               // centre bore radius
plate_t = 8;              // plate thickness, Z (extrusion height)
bore_d = 12;              // centre bore diameter
fit_tol = 0.1;            // declared fit tolerance (prompt contract)
free_tol = 0.5;           // declared free tolerance (prompt contract)

profile = [[38.971, 90], [23.221, 72.28], [0, 67.5], [7.471, 45], [0, 22.5], [23.221, 17.72], [38.971, 0], [54.721, 17.72], [77.942, 22.5], [70.471, 45], [77.942, 67.5], [54.721, 72.28]];  // primary outline, 12 points, counter clockwise
void_1 = [[44.861, 46.145], [44.114, 48.09], [42.747, 49.663], [40.925, 50.673], [38.866, 50.999], [36.821, 50.601], [35.035, 49.528], [33.723, 47.909], [33.045, 45.939], [33.081, 43.855], [33.828, 41.91], [35.195, 40.337], [37.018, 39.327], [39.076, 39.001], [41.121, 39.399], [42.907, 40.472], [44.219, 42.091], [44.897, 44.061]];  // centre bore, 18 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
