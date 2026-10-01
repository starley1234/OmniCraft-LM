$fn = 32;

// ----------------------------------------------------------------------
// Star wheel: 7-point blunt, R45
// ----------------------------------------------------------------------

// --- parameters (mm) ---
n_points = 7;             // number of points / teeth
r_out = 45;               // tip radius
r_in = 31.5;              // root radius
bore_r = 5;               // centre bore radius
plate_t = 5;              // plate thickness, Z (extrusion height)
bore_d = 10;              // centre bore diameter

profile = [[43.872, 85.544], [30.204, 68.924], [8.689, 68.601], [13.162, 47.553], [0, 30.53], [19.244, 20.904], [24.347, 0], [43.872, 9.044], [63.397, 0], [68.499, 20.904], [87.744, 30.53], [74.582, 47.553], [79.054, 68.601], [57.539, 68.924]];  // primary outline, 14 points, counter clockwise
void_1 = [[48.78, 41.498], [48.158, 43.119], [47.018, 44.429], [45.5, 45.271], [43.784, 45.543], [42.08, 45.212], [40.591, 44.317], [39.499, 42.968], [38.933, 41.326], [38.964, 39.59], [39.586, 37.968], [40.725, 36.658], [42.244, 35.816], [43.959, 35.544], [45.664, 35.876], [47.152, 36.77], [48.245, 38.12], [48.81, 39.761]];  // centre bore, 18 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
