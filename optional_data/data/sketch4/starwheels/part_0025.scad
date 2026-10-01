$fn = 32;

// ----------------------------------------------------------------------
// Star wheel: 8-point blunt, R40
// ----------------------------------------------------------------------

// --- parameters (mm) ---
n_points = 8;             // number of points / teeth
r_out = 40;               // tip radius
r_in = 28;                // root radius
bore_r = 4;               // centre bore radius
plate_t = 6;              // plate thickness, Z (extrusion height)
bore_d = 8;               // centre bore diameter
fit_tol = 0.1;            // declared fit tolerance (prompt contract)
free_tol = 0.5;           // declared free tolerance (prompt contract)

profile = [[80, 40], [65.869, 50.715], [68.284, 68.284], [50.715, 65.869], [40, 80], [29.285, 65.869], [11.716, 68.284], [14.131, 50.715], [0, 40], [14.131, 29.285], [11.716, 11.716], [29.285, 14.131], [40, 0], [50.715, 14.131], [68.284, 11.716], [65.869, 29.285]];  // primary outline, 16 points, counter clockwise
void_1 = [[43.927, 40.763], [43.429, 42.06], [42.517, 43.109], [41.302, 43.782], [39.93, 43.999], [38.567, 43.734], [37.376, 43.019], [36.502, 41.939], [36.049, 40.626], [36.073, 39.237], [36.571, 37.94], [37.483, 36.891], [38.698, 36.218], [40.07, 36.001], [41.433, 36.266], [42.624, 36.981], [43.498, 38.061], [43.951, 39.374]];  // centre bore, 18 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
