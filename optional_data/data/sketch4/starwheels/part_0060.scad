$fn = 32;

// ----------------------------------------------------------------------
// Star wheel: 8-point blunt, R45
// ----------------------------------------------------------------------

// --- parameters (mm) ---
n_points = 8;             // number of points / teeth
r_out = 45;               // tip radius
r_in = 31.5;              // root radius
bore_r = 4;               // centre bore radius
plate_t = 8;              // plate thickness, Z (extrusion height)
bore_d = 8;               // centre bore diameter

profile = [[0, 45], [15.898, 32.945], [13.18, 13.18], [32.945, 15.898], [45, 0], [57.055, 15.898], [76.82, 13.18], [74.102, 32.945], [90, 45], [74.102, 57.055], [76.82, 76.82], [57.055, 74.102], [45, 90], [32.945, 74.102], [13.18, 76.82], [15.898, 57.055]];  // primary outline, 16 points, counter clockwise
void_1 = [[48.927, 45.763], [48.429, 47.06], [47.517, 48.109], [46.302, 48.782], [44.93, 48.999], [43.567, 48.734], [42.376, 48.019], [41.502, 46.939], [41.049, 45.626], [41.073, 44.237], [41.571, 42.94], [42.483, 41.891], [43.698, 41.218], [45.07, 41.001], [46.433, 41.266], [47.624, 41.981], [48.498, 43.061], [48.951, 44.374]];  // centre bore, 18 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
