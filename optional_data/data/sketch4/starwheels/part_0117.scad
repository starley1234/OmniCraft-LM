$fn = 32;

// ----------------------------------------------------------------------
// Star wheel: 5-point star, R35
// ----------------------------------------------------------------------

// --- parameters (mm) ---
n_points = 5;             // number of points / teeth
r_out = 35;               // tip radius
r_in = 19.25;             // root radius
bore_r = 6;               // centre bore radius
plate_t = 8;              // plate thickness, Z (extrusion height)
bore_d = 12;              // centre bore diameter

profile = [[63.316, 33.287], [43.889, 44.602], [39.131, 66.574], [22.367, 51.595], [0, 53.859], [9.066, 33.287], [0, 12.714], [22.367, 14.979], [39.131, 0], [43.889, 21.972]];  // primary outline, 10 points, counter clockwise
void_1 = [[34.205, 34.432], [33.459, 36.377], [32.092, 37.95], [30.269, 38.96], [28.211, 39.286], [26.165, 38.888], [24.379, 37.815], [23.068, 36.196], [22.389, 34.226], [22.426, 32.142], [23.173, 30.197], [24.54, 28.624], [26.362, 27.614], [28.42, 27.288], [30.466, 27.685], [32.252, 28.759], [33.563, 30.378], [34.242, 32.348]];  // centre bore, 18 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
