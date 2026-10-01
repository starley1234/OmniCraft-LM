$fn = 32;

// ----------------------------------------------------------------------
// Star wheel: 7-point blunt, R40
// ----------------------------------------------------------------------

// --- parameters (mm) ---
n_points = 7;             // number of points / teeth
r_out = 40;               // tip radius
r_in = 26;                // root radius
bore_r = 5;               // centre bore radius
plate_t = 8;              // plate thickness, Z (extrusion height)
bore_d = 10;              // centre bore diameter

profile = [[38.997, 76.039], [27.716, 59.464], [7.724, 60.978], [13.649, 41.824], [0, 27.138], [18.669, 19.828], [21.642, 0], [38.997, 10.039], [56.352, 0], [59.325, 19.828], [77.994, 27.138], [64.345, 41.824], [70.27, 60.978], [50.278, 59.464]];  // primary outline, 14 points, counter clockwise
void_1 = [[43.905, 36.993], [43.283, 38.614], [42.144, 39.924], [40.625, 40.766], [38.91, 41.038], [37.205, 40.707], [35.717, 39.812], [34.624, 38.463], [34.059, 36.821], [34.089, 35.085], [34.711, 33.464], [35.851, 32.153], [37.369, 31.311], [39.084, 31.04], [40.789, 31.371], [42.277, 32.265], [43.37, 33.615], [43.936, 35.257]];  // centre bore, 18 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
