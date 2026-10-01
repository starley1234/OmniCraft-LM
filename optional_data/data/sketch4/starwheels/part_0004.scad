$fn = 32;

// ----------------------------------------------------------------------
// Star wheel: 6-point star, R30
// ----------------------------------------------------------------------

// --- parameters (mm) ---
n_points = 6;             // number of points / teeth
r_out = 30;               // tip radius
r_in = 15;                // root radius
bore_r = 6;               // centre bore radius
plate_t = 8;              // plate thickness, Z (extrusion height)
bore_d = 12;              // centre bore diameter

profile = [[0, 25.981], [17.01, 18.481], [15, 0], [30, 10.981], [45, 0], [42.99, 18.481], [60, 25.981], [42.99, 33.481], [45, 51.962], [30, 40.981], [15, 51.962], [17.01, 33.481]];  // primary outline, 12 points, counter clockwise
void_1 = [[35.89, 27.126], [35.143, 29.071], [33.776, 30.644], [31.953, 31.654], [29.895, 31.98], [27.85, 31.582], [26.064, 30.509], [24.752, 28.89], [24.074, 26.919], [24.11, 24.836], [24.857, 22.891], [26.224, 21.318], [28.047, 20.308], [30.105, 19.982], [32.15, 20.379], [33.936, 21.453], [35.248, 23.072], [35.926, 25.042]];  // centre bore, 18 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
