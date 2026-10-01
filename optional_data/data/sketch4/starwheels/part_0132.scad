$fn = 32;

// ----------------------------------------------------------------------
// Star wheel: 5-point blunt, R40
// ----------------------------------------------------------------------

// --- parameters (mm) ---
n_points = 5;             // number of points / teeth
r_out = 40;               // tip radius
r_in = 26;                // root radius
bore_r = 5;               // centre bore radius
plate_t = 6;              // plate thickness, Z (extrusion height)
bore_d = 10;              // centre bore diameter

profile = [[72.361, 38.042], [53.395, 53.325], [44.721, 76.085], [24.326, 62.77], [0, 61.554], [6.361, 38.042], [0, 14.531], [24.326, 13.315], [44.721, 0], [53.395, 22.76]];  // primary outline, 10 points, counter clockwise
void_1 = [[37.269, 38.996], [36.647, 40.617], [35.507, 41.928], [33.989, 42.77], [32.273, 43.041], [30.569, 42.71], [29.08, 41.816], [27.988, 40.466], [27.422, 38.824], [27.453, 37.088], [28.075, 35.467], [29.214, 34.157], [30.733, 33.315], [32.448, 33.043], [34.153, 33.374], [35.641, 34.269], [36.734, 35.618], [37.299, 37.26]];  // centre bore, 18 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
