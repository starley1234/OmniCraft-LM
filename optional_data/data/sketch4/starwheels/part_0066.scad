$fn = 32;

// ----------------------------------------------------------------------
// Star wheel: 7-point blunt, R40
// ----------------------------------------------------------------------

// --- parameters (mm) ---
n_points = 7;             // number of points / teeth
r_out = 40;               // tip radius
r_in = 24;                // root radius
bore_r = 5;               // centre bore radius
plate_t = 8;              // plate thickness, Z (extrusion height)
bore_d = 10;              // centre bore diameter

profile = [[76.039, 38.997], [57.662, 49.41], [60.978, 70.27], [41.379, 62.395], [27.138, 77.994], [21.075, 57.761], [0, 56.352], [12.039, 38.997], [0, 21.642], [21.075, 20.233], [27.138, 0], [41.379, 15.599], [60.978, 7.724], [57.662, 28.584]];  // primary outline, 14 points, counter clockwise
void_1 = [[40.947, 39.951], [40.325, 41.572], [39.185, 42.883], [37.667, 43.725], [35.951, 43.996], [34.247, 43.665], [32.758, 42.771], [31.666, 41.421], [31.1, 39.779], [31.131, 38.043], [31.753, 36.422], [32.892, 35.111], [34.411, 34.27], [36.126, 33.998], [37.831, 34.329], [39.319, 35.224], [40.412, 36.573], [40.977, 38.215]];  // centre bore, 18 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
