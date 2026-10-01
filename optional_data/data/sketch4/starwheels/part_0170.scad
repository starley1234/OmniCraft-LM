$fn = 32;

// ----------------------------------------------------------------------
// Star wheel: 8-point star, R40
// ----------------------------------------------------------------------

// --- parameters (mm) ---
n_points = 8;             // number of points / teeth
r_out = 40;               // tip radius
r_in = 24;                // root radius
bore_r = 4;               // centre bore radius
plate_t = 5;              // plate thickness, Z (extrusion height)
bore_d = 8;               // centre bore diameter

profile = [[80, 40], [62.173, 49.184], [68.284, 68.284], [49.184, 62.173], [40, 80], [30.816, 62.173], [11.716, 68.284], [17.827, 49.184], [0, 40], [17.827, 30.816], [11.716, 11.716], [30.816, 17.827], [40, 0], [49.184, 17.827], [68.284, 11.716], [62.173, 30.816]];  // primary outline, 16 points, counter clockwise
void_1 = [[43.927, 40.763], [43.429, 42.06], [42.517, 43.109], [41.302, 43.782], [39.93, 43.999], [38.567, 43.734], [37.376, 43.019], [36.502, 41.939], [36.049, 40.626], [36.073, 39.237], [36.571, 37.94], [37.483, 36.891], [38.698, 36.218], [40.07, 36.001], [41.433, 36.266], [42.624, 36.981], [43.498, 38.061], [43.951, 39.374]];  // centre bore, 18 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
