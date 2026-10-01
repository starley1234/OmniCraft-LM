$fn = 32;

// ----------------------------------------------------------------------
// Star wheel: 8-point blunt, R30
// ----------------------------------------------------------------------

// --- parameters (mm) ---
n_points = 8;             // number of points / teeth
r_out = 30;               // tip radius
r_in = 21;                // root radius
bore_r = 6;               // centre bore radius
plate_t = 5;              // plate thickness, Z (extrusion height)
bore_d = 12;              // centre bore diameter

profile = [[30, 60], [21.964, 49.401], [8.787, 51.213], [10.599, 38.036], [0, 30], [10.599, 21.964], [8.787, 8.787], [21.964, 10.599], [30, 0], [38.036, 10.599], [51.213, 8.787], [49.401, 21.964], [60, 30], [49.401, 38.036], [51.213, 51.213], [38.036, 49.401]];  // primary outline, 16 points, counter clockwise
void_1 = [[35.89, 31.145], [35.143, 33.09], [33.776, 34.663], [31.953, 35.673], [29.895, 35.999], [27.85, 35.601], [26.064, 34.528], [24.752, 32.909], [24.074, 30.939], [24.11, 28.855], [24.857, 26.91], [26.224, 25.337], [28.047, 24.327], [30.105, 24.001], [32.15, 24.399], [33.936, 25.472], [35.248, 27.091], [35.926, 29.061]];  // centre bore, 18 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
