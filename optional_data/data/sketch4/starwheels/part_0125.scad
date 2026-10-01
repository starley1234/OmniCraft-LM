$fn = 32;

// ----------------------------------------------------------------------
// Star wheel: 7-point blunt, R40
// ----------------------------------------------------------------------

// --- parameters (mm) ---
n_points = 7;             // number of points / teeth
r_out = 40;               // tip radius
r_in = 24;                // root radius
bore_r = 5;               // centre bore radius
plate_t = 5;              // plate thickness, Z (extrusion height)
bore_d = 10;              // centre bore diameter

profile = [[38.997, 76.039], [28.584, 57.662], [7.724, 60.978], [15.599, 41.379], [0, 27.138], [20.233, 21.075], [21.642, 0], [38.997, 12.039], [56.352, 0], [57.761, 21.075], [77.994, 27.138], [62.395, 41.379], [70.27, 60.978], [49.41, 57.662]];  // primary outline, 14 points, counter clockwise
void_1 = [[43.905, 36.993], [43.283, 38.614], [42.144, 39.924], [40.625, 40.766], [38.91, 41.038], [37.205, 40.707], [35.717, 39.812], [34.624, 38.463], [34.059, 36.821], [34.089, 35.085], [34.711, 33.464], [35.851, 32.153], [37.369, 31.311], [39.084, 31.04], [40.789, 31.371], [42.277, 32.265], [43.37, 33.615], [43.936, 35.257]];  // centre bore, 18 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
