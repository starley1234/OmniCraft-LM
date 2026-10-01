$fn = 32;

// ----------------------------------------------------------------------
// Star wheel: 8-point blunt, R30
// ----------------------------------------------------------------------

// --- parameters (mm) ---
n_points = 8;             // number of points / teeth
r_out = 30;               // tip radius
r_in = 19.5;              // root radius
bore_r = 5;               // centre bore radius
plate_t = 5;              // plate thickness, Z (extrusion height)
bore_d = 10;              // centre bore diameter

profile = [[60, 30], [48.016, 37.462], [51.213, 51.213], [37.462, 48.016], [30, 60], [22.538, 48.016], [8.787, 51.213], [11.984, 37.462], [0, 30], [11.984, 22.538], [8.787, 8.787], [22.538, 11.984], [30, 0], [37.462, 11.984], [51.213, 8.787], [48.016, 22.538]];  // primary outline, 16 points, counter clockwise
void_1 = [[34.908, 30.954], [34.286, 32.575], [33.147, 33.886], [31.628, 34.728], [29.913, 34.999], [28.208, 34.668], [26.72, 33.774], [25.627, 32.424], [25.062, 30.782], [25.092, 29.046], [25.714, 27.425], [26.853, 26.114], [28.372, 25.272], [30.087, 25.001], [31.792, 25.332], [33.28, 26.226], [34.373, 27.576], [34.938, 29.218]];  // centre bore, 18 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
