$fn = 32;

// ----------------------------------------------------------------------
// Star wheel: 8-point blunt, R35
// ----------------------------------------------------------------------

// --- parameters (mm) ---
n_points = 8;             // number of points / teeth
r_out = 35;               // tip radius
r_in = 24.5;              // root radius
bore_r = 6;               // centre bore radius
plate_t = 5;              // plate thickness, Z (extrusion height)
bore_d = 12;              // centre bore diameter

profile = [[70, 35], [57.635, 44.376], [59.749, 59.749], [44.376, 57.635], [35, 70], [25.624, 57.635], [10.251, 59.749], [12.365, 44.376], [0, 35], [12.365, 25.624], [10.251, 10.251], [25.624, 12.365], [35, 0], [44.376, 12.365], [59.749, 10.251], [57.635, 25.624]];  // primary outline, 16 points, counter clockwise
void_1 = [[40.89, 36.145], [40.143, 38.09], [38.776, 39.663], [36.953, 40.673], [34.895, 40.999], [32.85, 40.601], [31.064, 39.528], [29.752, 37.909], [29.074, 35.939], [29.11, 33.855], [29.857, 31.91], [31.224, 30.337], [33.047, 29.327], [35.105, 29.001], [37.15, 29.399], [38.936, 30.472], [40.248, 32.091], [40.926, 34.061]];  // centre bore, 18 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
