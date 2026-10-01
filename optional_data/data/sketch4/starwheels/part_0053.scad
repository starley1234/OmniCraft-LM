$fn = 32;

// ----------------------------------------------------------------------
// Star wheel: 7-point blunt, R45
// ----------------------------------------------------------------------

// --- parameters (mm) ---
n_points = 7;             // number of points / teeth
r_out = 45;               // tip radius
r_in = 31.5;              // root radius
bore_r = 4;               // centre bore radius
plate_t = 6;              // plate thickness, Z (extrusion height)
bore_d = 8;               // centre bore diameter

profile = [[85.544, 43.872], [68.924, 57.539], [68.601, 79.054], [47.553, 74.582], [30.53, 87.744], [20.904, 68.499], [0, 63.397], [9.044, 43.872], [0, 24.347], [20.904, 19.244], [30.53, 0], [47.553, 13.162], [68.601, 8.689], [68.924, 30.204]];  // primary outline, 14 points, counter clockwise
void_1 = [[44.47, 44.635], [43.972, 45.932], [43.061, 46.98], [41.846, 47.654], [40.474, 47.871], [39.11, 47.606], [37.919, 46.891], [37.045, 45.811], [36.593, 44.497], [36.617, 43.109], [37.115, 41.812], [38.026, 40.763], [39.241, 40.09], [40.613, 39.872], [41.977, 40.137], [43.168, 40.853], [44.042, 41.933], [44.494, 43.246]];  // centre bore, 18 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
