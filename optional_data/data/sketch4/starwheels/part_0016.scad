$fn = 32;

// ----------------------------------------------------------------------
// Star wheel: 7-point star, R45
// ----------------------------------------------------------------------

// --- parameters (mm) ---
n_points = 7;             // number of points / teeth
r_out = 45;               // tip radius
r_in = 24.75;             // root radius
bore_r = 6;               // centre bore radius
plate_t = 5;              // plate thickness, Z (extrusion height)
bore_d = 12;              // centre bore diameter

profile = [[0, 43.872], [22.701, 33.133], [16.943, 8.689], [39.493, 19.742], [55.013, 0], [60.431, 24.521], [85.544, 24.347], [69.75, 43.872], [85.544, 63.397], [60.431, 63.222], [55.013, 87.744], [39.493, 68.001], [16.943, 79.054], [22.701, 54.61]];  // primary outline, 14 points, counter clockwise
void_1 = [[50.89, 45.017], [50.143, 46.962], [48.776, 48.535], [46.953, 49.545], [44.895, 49.871], [42.85, 49.473], [41.064, 48.4], [39.752, 46.781], [39.074, 44.81], [39.11, 42.727], [39.857, 40.782], [41.224, 39.209], [43.047, 38.199], [45.105, 37.873], [47.15, 38.27], [48.936, 39.343], [50.248, 40.963], [50.926, 42.933]];  // centre bore, 18 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
