$fn = 32;

// ----------------------------------------------------------------------
// Star wheel: 8-point star, R45
// ----------------------------------------------------------------------

// --- parameters (mm) ---
n_points = 8;             // number of points / teeth
r_out = 45;               // tip radius
r_in = 27;                // root radius
bore_r = 4;               // centre bore radius
plate_t = 8;              // plate thickness, Z (extrusion height)
bore_d = 8;               // centre bore diameter
fit_tol = 0.05;           // declared fit tolerance (prompt contract)
free_tol = 0.2;           // declared free tolerance (prompt contract)

profile = [[0, 45], [20.055, 34.668], [13.18, 13.18], [34.668, 20.055], [45, 0], [55.332, 20.055], [76.82, 13.18], [69.945, 34.668], [90, 45], [69.945, 55.332], [76.82, 76.82], [55.332, 69.945], [45, 90], [34.668, 69.945], [13.18, 76.82], [20.055, 55.332]];  // primary outline, 16 points, counter clockwise
void_1 = [[48.927, 45.763], [48.429, 47.06], [47.517, 48.109], [46.302, 48.782], [44.93, 48.999], [43.567, 48.734], [42.376, 48.019], [41.502, 46.939], [41.049, 45.626], [41.073, 44.237], [41.571, 42.94], [42.483, 41.891], [43.698, 41.218], [45.07, 41.001], [46.433, 41.266], [47.624, 41.981], [48.498, 43.061], [48.951, 44.374]];  // centre bore, 18 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
