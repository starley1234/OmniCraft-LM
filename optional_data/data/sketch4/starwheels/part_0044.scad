$fn = 32;

// ----------------------------------------------------------------------
// Star wheel: 5-point blunt, R35
// ----------------------------------------------------------------------

// --- parameters (mm) ---
n_points = 5;             // number of points / teeth
r_out = 35;               // tip radius
r_in = 24.5;              // root radius
bore_r = 6;               // centre bore radius
plate_t = 8;              // plate thickness, Z (extrusion height)
bore_d = 12;              // centre bore diameter

profile = [[0, 33.287], [15.179, 18.886], [24.184, 0], [42.571, 9.986], [63.316, 12.714], [59.5, 33.287], [63.316, 53.859], [42.571, 56.588], [24.184, 66.574], [15.179, 47.688]];  // primary outline, 10 points, counter clockwise
void_1 = [[40.89, 34.432], [40.143, 36.377], [38.776, 37.95], [36.953, 38.96], [34.895, 39.286], [32.85, 38.888], [31.064, 37.815], [29.752, 36.196], [29.074, 34.226], [29.11, 32.142], [29.857, 30.197], [31.224, 28.624], [33.047, 27.614], [35.105, 27.288], [37.15, 27.685], [38.936, 28.759], [40.248, 30.378], [40.926, 32.348]];  // centre bore, 18 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
