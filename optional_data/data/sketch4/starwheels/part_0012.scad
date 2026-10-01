$fn = 32;

// ----------------------------------------------------------------------
// Star wheel: 5-point star, R40
// ----------------------------------------------------------------------

// --- parameters (mm) ---
n_points = 5;             // number of points / teeth
r_out = 40;               // tip radius
r_in = 22;                // root radius
bore_r = 6;               // centre bore radius
plate_t = 5;              // plate thickness, Z (extrusion height)
bore_d = 12;              // centre bore diameter

profile = [[0, 38.042], [22.202, 25.111], [27.639, 0], [46.798, 17.119], [72.361, 14.531], [62, 38.042], [72.361, 61.554], [46.798, 58.966], [27.639, 76.085], [22.202, 50.974]];  // primary outline, 10 points, counter clockwise
void_1 = [[45.89, 39.187], [45.143, 41.132], [43.776, 42.705], [41.953, 43.715], [39.895, 44.041], [37.85, 43.644], [36.064, 42.571], [34.752, 40.951], [34.074, 38.981], [34.11, 36.897], [34.857, 34.952], [36.224, 33.379], [38.047, 32.369], [40.105, 32.043], [42.15, 32.441], [43.936, 33.514], [45.248, 35.133], [45.926, 37.104]];  // centre bore, 18 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
