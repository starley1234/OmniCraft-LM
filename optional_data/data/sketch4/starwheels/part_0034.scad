$fn = 32;

// ----------------------------------------------------------------------
// Star wheel: 6-point blunt, R35
// ----------------------------------------------------------------------

// --- parameters (mm) ---
n_points = 6;             // number of points / teeth
r_out = 35;               // tip radius
r_in = 24.5;              // root radius
bore_r = 4;               // centre bore radius
plate_t = 5;              // plate thickness, Z (extrusion height)
bore_d = 8;               // centre bore diameter

profile = [[30.311, 70], [18.061, 56.218], [0, 52.5], [5.811, 35], [0, 17.5], [18.061, 13.782], [30.311, 0], [42.561, 13.782], [60.622, 17.5], [54.811, 35], [60.622, 52.5], [42.561, 56.218]];  // primary outline, 12 points, counter clockwise
void_1 = [[34.237, 35.763], [33.74, 37.06], [32.828, 38.109], [31.613, 38.782], [30.241, 38.999], [28.877, 38.734], [27.687, 38.019], [26.812, 36.939], [26.36, 35.626], [26.384, 34.237], [26.882, 32.94], [27.794, 31.891], [29.009, 31.218], [30.381, 31.001], [31.744, 31.266], [32.935, 31.981], [33.809, 33.061], [34.262, 34.374]];  // centre bore, 18 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
