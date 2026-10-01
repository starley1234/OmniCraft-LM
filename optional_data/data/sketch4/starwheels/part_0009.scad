$fn = 32;

// ----------------------------------------------------------------------
// Star wheel: 7-point blunt, R45
// ----------------------------------------------------------------------

// --- parameters (mm) ---
n_points = 7;             // number of points / teeth
r_out = 45;               // tip radius
r_in = 31.5;              // root radius
bore_r = 6;               // centre bore radius
plate_t = 8;              // plate thickness, Z (extrusion height)
bore_d = 12;              // centre bore diameter

profile = [[43.872, 85.544], [30.204, 68.924], [8.689, 68.601], [13.162, 47.553], [0, 30.53], [19.244, 20.904], [24.347, 0], [43.872, 9.044], [63.397, 0], [68.499, 20.904], [87.744, 30.53], [74.582, 47.553], [79.054, 68.601], [57.539, 68.924]];  // primary outline, 14 points, counter clockwise
void_1 = [[49.762, 41.688], [49.015, 43.634], [47.648, 45.206], [45.825, 46.217], [43.767, 46.543], [41.722, 46.145], [39.935, 45.072], [38.624, 43.452], [37.946, 41.482], [37.982, 39.399], [38.729, 37.453], [40.096, 35.881], [41.918, 34.87], [43.976, 34.545], [46.022, 34.942], [47.808, 36.015], [49.119, 37.635], [49.798, 39.605]];  // centre bore, 18 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
