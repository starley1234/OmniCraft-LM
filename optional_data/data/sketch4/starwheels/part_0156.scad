$fn = 32;

// ----------------------------------------------------------------------
// Star wheel: 6-point blunt, R35
// ----------------------------------------------------------------------

// --- parameters (mm) ---
n_points = 6;             // number of points / teeth
r_out = 35;               // tip radius
r_in = 21;                // root radius
bore_r = 6;               // centre bore radius
plate_t = 5;              // plate thickness, Z (extrusion height)
bore_d = 12;              // centre bore diameter

profile = [[30.311, 70], [19.811, 53.187], [0, 52.5], [9.311, 35], [0, 17.5], [19.811, 16.813], [30.311, 0], [40.811, 16.813], [60.622, 17.5], [51.311, 35], [60.622, 52.5], [40.811, 53.187]];  // primary outline, 12 points, counter clockwise
void_1 = [[36.201, 36.145], [35.454, 38.09], [34.087, 39.663], [32.264, 40.673], [30.206, 40.999], [28.161, 40.601], [26.375, 39.528], [25.063, 37.909], [24.385, 35.939], [24.421, 33.855], [25.168, 31.91], [26.535, 30.337], [28.357, 29.327], [30.416, 29.001], [32.461, 29.399], [34.247, 30.472], [35.559, 32.091], [36.237, 34.061]];  // centre bore, 18 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
