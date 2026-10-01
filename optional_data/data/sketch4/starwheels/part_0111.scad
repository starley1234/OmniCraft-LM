$fn = 32;

// ----------------------------------------------------------------------
// Star wheel: 8-point blunt, R30
// ----------------------------------------------------------------------

// --- parameters (mm) ---
n_points = 8;             // number of points / teeth
r_out = 30;               // tip radius
r_in = 18;                // root radius
bore_r = 4;               // centre bore radius
plate_t = 8;              // plate thickness, Z (extrusion height)
bore_d = 8;               // centre bore diameter

profile = [[0, 30], [13.37, 23.112], [8.787, 8.787], [23.112, 13.37], [30, 0], [36.888, 13.37], [51.213, 8.787], [46.63, 23.112], [60, 30], [46.63, 36.888], [51.213, 51.213], [36.888, 46.63], [30, 60], [23.112, 46.63], [8.787, 51.213], [13.37, 36.888]];  // primary outline, 16 points, counter clockwise
void_1 = [[33.927, 30.763], [33.429, 32.06], [32.517, 33.109], [31.302, 33.782], [29.93, 33.999], [28.567, 33.734], [27.376, 33.019], [26.502, 31.939], [26.049, 30.626], [26.073, 29.237], [26.571, 27.94], [27.483, 26.891], [28.698, 26.218], [30.07, 26.001], [31.433, 26.266], [32.624, 26.981], [33.498, 28.061], [33.951, 29.374]];  // centre bore, 18 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
