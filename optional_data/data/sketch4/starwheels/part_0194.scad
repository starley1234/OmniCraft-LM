$fn = 32;

// ----------------------------------------------------------------------
// Star wheel: 6-point blunt, R30
// ----------------------------------------------------------------------

// --- parameters (mm) ---
n_points = 6;             // number of points / teeth
r_out = 30;               // tip radius
r_in = 18;                // root radius
bore_r = 4;               // centre bore radius
plate_t = 8;              // plate thickness, Z (extrusion height)
bore_d = 8;               // centre bore diameter

profile = [[25.981, 60], [16.981, 45.588], [0, 45], [7.981, 30], [0, 15], [16.981, 14.412], [25.981, 0], [34.981, 14.412], [51.962, 15], [43.981, 30], [51.962, 45], [34.981, 45.588]];  // primary outline, 12 points, counter clockwise
void_1 = [[29.907, 30.763], [29.409, 32.06], [28.498, 33.109], [27.283, 33.782], [25.911, 33.999], [24.547, 33.734], [23.357, 33.019], [22.482, 31.939], [22.03, 30.626], [22.054, 29.237], [22.552, 27.94], [23.463, 26.891], [24.678, 26.218], [26.051, 26.001], [27.414, 26.266], [28.605, 26.981], [29.479, 28.061], [29.932, 29.374]];  // centre bore, 18 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
