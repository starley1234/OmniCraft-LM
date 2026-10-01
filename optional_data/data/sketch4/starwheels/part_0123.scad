$fn = 32;

// ----------------------------------------------------------------------
// Star wheel: 8-point star, R35
// ----------------------------------------------------------------------

// --- parameters (mm) ---
n_points = 8;             // number of points / teeth
r_out = 35;               // tip radius
r_in = 21;                // root radius
bore_r = 6;               // centre bore radius
plate_t = 6;              // plate thickness, Z (extrusion height)
bore_d = 12;              // centre bore diameter

profile = [[0, 35], [15.599, 26.964], [10.251, 10.251], [26.964, 15.599], [35, 0], [43.036, 15.599], [59.749, 10.251], [54.401, 26.964], [70, 35], [54.401, 43.036], [59.749, 59.749], [43.036, 54.401], [35, 70], [26.964, 54.401], [10.251, 59.749], [15.599, 43.036]];  // primary outline, 16 points, counter clockwise
void_1 = [[40.89, 36.145], [40.143, 38.09], [38.776, 39.663], [36.953, 40.673], [34.895, 40.999], [32.85, 40.601], [31.064, 39.528], [29.752, 37.909], [29.074, 35.939], [29.11, 33.855], [29.857, 31.91], [31.224, 30.337], [33.047, 29.327], [35.105, 29.001], [37.15, 29.399], [38.936, 30.472], [40.248, 32.091], [40.926, 34.061]];  // centre bore, 18 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
