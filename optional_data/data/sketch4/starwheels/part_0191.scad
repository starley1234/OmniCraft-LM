$fn = 32;

// ----------------------------------------------------------------------
// Star wheel: 6-point blunt, R35
// ----------------------------------------------------------------------

// --- parameters (mm) ---
n_points = 6;             // number of points / teeth
r_out = 35;               // tip radius
r_in = 22.75;             // root radius
bore_r = 6;               // centre bore radius
plate_t = 8;              // plate thickness, Z (extrusion height)
bore_d = 12;              // centre bore diameter

profile = [[0, 30.311], [15.298, 18.936], [17.5, 0], [35, 7.561], [52.5, 0], [54.702, 18.936], [70, 30.311], [54.702, 41.686], [52.5, 60.622], [35, 53.061], [17.5, 60.622], [15.298, 41.686]];  // primary outline, 12 points, counter clockwise
void_1 = [[40.89, 31.456], [40.143, 33.401], [38.776, 34.974], [36.953, 35.984], [34.895, 36.31], [32.85, 35.912], [31.064, 34.839], [29.752, 33.22], [29.074, 31.249], [29.11, 29.166], [29.857, 27.221], [31.224, 25.648], [33.047, 24.638], [35.105, 24.312], [37.15, 24.709], [38.936, 25.783], [40.248, 27.402], [40.926, 29.372]];  // centre bore, 18 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
