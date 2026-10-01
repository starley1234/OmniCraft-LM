$fn = 32;

// ----------------------------------------------------------------------
// Star wheel: 5-point star, R40
// ----------------------------------------------------------------------

// --- parameters (mm) ---
n_points = 5;             // number of points / teeth
r_out = 40;               // tip radius
r_in = 20;                // root radius
bore_r = 5;               // centre bore radius
plate_t = 8;              // plate thickness, Z (extrusion height)
bore_d = 10;              // centre bore diameter

profile = [[0, 38.042], [23.82, 26.287], [27.639, 0], [46.18, 19.021], [72.361, 14.531], [60, 38.042], [72.361, 61.554], [46.18, 57.063], [27.639, 76.085], [23.82, 49.798]];  // primary outline, 10 points, counter clockwise
void_1 = [[44.908, 38.996], [44.286, 40.617], [43.147, 41.928], [41.628, 42.77], [39.913, 43.041], [38.208, 42.71], [36.72, 41.816], [35.627, 40.466], [35.062, 38.824], [35.092, 37.088], [35.714, 35.467], [36.853, 34.157], [38.372, 33.315], [40.087, 33.043], [41.792, 33.374], [43.28, 34.269], [44.373, 35.618], [44.938, 37.26]];  // centre bore, 18 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
