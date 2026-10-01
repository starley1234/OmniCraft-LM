$fn = 32;

// ----------------------------------------------------------------------
// Star wheel: 5-point star, R40
// ----------------------------------------------------------------------

// --- parameters (mm) ---
n_points = 5;             // number of points / teeth
r_out = 40;               // tip radius
r_in = 24;                // root radius
bore_r = 4;               // centre bore radius
plate_t = 5;              // plate thickness, Z (extrusion height)
bore_d = 8;               // centre bore diameter

profile = [[0, 38.042], [20.584, 23.935], [27.639, 0], [47.416, 15.217], [72.361, 14.531], [64, 38.042], [72.361, 61.554], [47.416, 60.868], [27.639, 76.085], [20.584, 52.149]];  // primary outline, 10 points, counter clockwise
void_1 = [[43.927, 38.805], [43.429, 40.102], [42.517, 41.151], [41.302, 41.824], [39.93, 42.042], [38.567, 41.777], [37.376, 41.061], [36.502, 39.981], [36.049, 38.668], [36.073, 37.279], [36.571, 35.982], [37.483, 34.934], [38.698, 34.26], [40.07, 34.043], [41.433, 34.308], [42.624, 35.023], [43.498, 36.103], [43.951, 37.417]];  // centre bore, 18 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
