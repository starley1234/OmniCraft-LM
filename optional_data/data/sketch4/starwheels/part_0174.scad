$fn = 32;

// ----------------------------------------------------------------------
// Star wheel: 7-point blunt, R45
// ----------------------------------------------------------------------

// --- parameters (mm) ---
n_points = 7;             // number of points / teeth
r_out = 45;               // tip radius
r_in = 27;                // root radius
bore_r = 6;               // centre bore radius
plate_t = 6;              // plate thickness, Z (extrusion height)
bore_d = 12;              // centre bore diameter
fit_tol = 0.1;            // declared fit tolerance (prompt contract)
free_tol = 0.5;           // declared free tolerance (prompt contract)

profile = [[85.544, 43.872], [64.87, 55.587], [68.601, 79.054], [46.552, 70.195], [30.53, 87.744], [23.709, 64.981], [0, 63.397], [13.544, 43.872], [0, 24.347], [23.709, 22.762], [30.53, 0], [46.552, 17.549], [68.601, 8.689], [64.87, 32.157]];  // primary outline, 14 points, counter clockwise
void_1 = [[46.433, 45.017], [45.687, 46.962], [44.32, 48.535], [42.497, 49.545], [40.439, 49.871], [38.393, 49.473], [36.607, 48.4], [35.296, 46.781], [34.617, 44.81], [34.654, 42.727], [35.401, 40.782], [36.768, 39.209], [38.59, 38.199], [40.648, 37.873], [42.694, 38.27], [44.48, 39.343], [45.791, 40.963], [46.47, 42.933]];  // centre bore, 18 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
