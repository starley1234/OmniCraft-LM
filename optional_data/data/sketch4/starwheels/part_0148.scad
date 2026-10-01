$fn = 32;

// ----------------------------------------------------------------------
// Star wheel: 7-point blunt, R35
// ----------------------------------------------------------------------

// --- parameters (mm) ---
n_points = 7;             // number of points / teeth
r_out = 35;               // tip radius
r_in = 24.5;              // root radius
bore_r = 5;               // centre bore radius
plate_t = 5;              // plate thickness, Z (extrusion height)
bore_d = 10;              // centre bore diameter

profile = [[0, 34.122], [12.926, 23.492], [13.178, 6.758], [29.548, 10.237], [42.788, 0], [50.276, 14.968], [66.534, 18.937], [59.5, 34.122], [66.534, 49.308], [50.276, 53.277], [42.788, 68.245], [29.548, 58.008], [13.178, 61.487], [12.926, 44.753]];  // primary outline, 14 points, counter clockwise
void_1 = [[39.908, 35.077], [39.286, 36.698], [38.147, 38.008], [36.628, 38.85], [34.913, 39.122], [33.208, 38.79], [31.72, 37.896], [30.627, 36.547], [30.062, 34.905], [30.092, 33.168], [30.714, 31.547], [31.853, 30.237], [33.372, 29.395], [35.087, 29.123], [36.792, 29.455], [38.28, 30.349], [39.373, 31.698], [39.938, 33.34]];  // centre bore, 18 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
