$fn = 32;

// ----------------------------------------------------------------------
// Star wheel: 5-point blunt, R40
// ----------------------------------------------------------------------

// --- parameters (mm) ---
n_points = 5;             // number of points / teeth
r_out = 40;               // tip radius
r_in = 26;                // root radius
bore_r = 5;               // centre bore radius
plate_t = 6;              // plate thickness, Z (extrusion height)
bore_d = 10;              // centre bore diameter

profile = [[38.042, 72.361], [22.76, 53.395], [0, 44.721], [13.315, 24.326], [14.531, 0], [38.042, 6.361], [61.554, 0], [62.77, 24.326], [76.085, 44.721], [53.325, 53.395]];  // primary outline, 10 points, counter clockwise
void_1 = [[42.95, 33.315], [42.328, 34.936], [41.189, 36.246], [39.67, 37.088], [37.955, 37.36], [36.25, 37.029], [34.762, 36.134], [33.669, 34.785], [33.104, 33.143], [33.134, 31.407], [33.756, 29.785], [34.896, 28.475], [36.414, 27.633], [38.13, 27.361], [39.834, 27.693], [41.323, 28.587], [42.415, 29.937], [42.981, 31.579]];  // centre bore, 18 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
