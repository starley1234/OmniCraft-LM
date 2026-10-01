$fn = 32;

// ----------------------------------------------------------------------
// Star wheel: 5-point star, R40
// ----------------------------------------------------------------------

// --- parameters (mm) ---
n_points = 5;             // number of points / teeth
r_out = 40;               // tip radius
r_in = 22;                // root radius
bore_r = 4;               // centre bore radius
plate_t = 5;              // plate thickness, Z (extrusion height)
bore_d = 8;               // centre bore diameter

profile = [[72.361, 38.042], [50.159, 50.974], [44.721, 76.085], [25.562, 58.966], [0, 61.554], [10.361, 38.042], [0, 14.531], [25.562, 17.119], [44.721, 0], [50.159, 25.111]];  // primary outline, 10 points, counter clockwise
void_1 = [[36.287, 38.805], [35.789, 40.102], [34.878, 41.151], [33.663, 41.824], [32.291, 42.042], [30.927, 41.777], [29.736, 41.061], [28.862, 39.981], [28.41, 38.668], [28.434, 37.279], [28.932, 35.982], [29.843, 34.934], [31.058, 34.26], [32.43, 34.043], [33.794, 34.308], [34.985, 35.023], [35.859, 36.103], [36.311, 37.417]];  // centre bore, 18 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
