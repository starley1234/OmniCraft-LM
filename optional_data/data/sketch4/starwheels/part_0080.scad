$fn = 32;

// ----------------------------------------------------------------------
// Star wheel: 5-point blunt, R40
// ----------------------------------------------------------------------

// --- parameters (mm) ---
n_points = 5;             // number of points / teeth
r_out = 40;               // tip radius
r_in = 28;                // root radius
bore_r = 6;               // centre bore radius
plate_t = 5;              // plate thickness, Z (extrusion height)
bore_d = 12;              // centre bore diameter
fit_tol = 0.1;            // declared fit tolerance (prompt contract)
free_tol = 0.5;           // declared free tolerance (prompt contract)

profile = [[72.361, 38.042], [55.013, 54.5], [44.721, 76.085], [23.708, 64.672], [0, 61.554], [4.361, 38.042], [0, 14.531], [23.708, 11.413], [44.721, 0], [55.013, 21.584]];  // primary outline, 10 points, counter clockwise
void_1 = [[38.25, 39.187], [37.504, 41.132], [36.137, 42.705], [34.314, 43.715], [32.256, 44.041], [30.21, 43.644], [28.424, 42.571], [27.113, 40.951], [26.435, 38.981], [26.471, 36.897], [27.218, 34.952], [28.585, 33.379], [30.407, 32.369], [32.465, 32.043], [34.511, 32.441], [36.297, 33.514], [37.608, 35.133], [38.287, 37.104]];  // centre bore, 18 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
