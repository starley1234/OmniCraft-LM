$fn = 32;

// ----------------------------------------------------------------------
// Star wheel: 7-point blunt, R40
// ----------------------------------------------------------------------

// --- parameters (mm) ---
n_points = 7;             // number of points / teeth
r_out = 40;               // tip radius
r_in = 28;                // root radius
bore_r = 6;               // centre bore radius
plate_t = 8;              // plate thickness, Z (extrusion height)
bore_d = 12;              // centre bore diameter
fit_tol = 0.05;           // declared fit tolerance (prompt contract)
free_tol = 0.2;           // declared free tolerance (prompt contract)

profile = [[0, 38.997], [14.773, 26.848], [15.06, 7.724], [33.769, 11.699], [48.901, 0], [57.458, 17.106], [76.039, 21.642], [68, 38.997], [76.039, 56.352], [57.458, 60.888], [48.901, 77.994], [33.769, 66.295], [15.06, 70.27], [14.773, 51.146]];  // primary outline, 14 points, counter clockwise
void_1 = [[45.89, 40.142], [45.143, 42.087], [43.776, 43.66], [41.953, 44.67], [39.895, 44.996], [37.85, 44.599], [36.064, 43.525], [34.752, 41.906], [34.074, 39.936], [34.11, 37.852], [34.857, 35.907], [36.224, 34.334], [38.047, 33.324], [40.105, 32.998], [42.15, 33.396], [43.936, 34.469], [45.248, 36.088], [45.926, 38.059]];  // centre bore, 18 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
