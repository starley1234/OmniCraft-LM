$fn = 32;

// ----------------------------------------------------------------------
// Star wheel: 8-point blunt, R35
// ----------------------------------------------------------------------

// --- parameters (mm) ---
n_points = 8;             // number of points / teeth
r_out = 35;               // tip radius
r_in = 24.5;              // root radius
bore_r = 5;               // centre bore radius
plate_t = 6;              // plate thickness, Z (extrusion height)
bore_d = 10;              // centre bore diameter

profile = [[35, 70], [25.624, 57.635], [10.251, 59.749], [12.365, 44.376], [0, 35], [12.365, 25.624], [10.251, 10.251], [25.624, 12.365], [35, 0], [44.376, 12.365], [59.749, 10.251], [57.635, 25.624], [70, 35], [57.635, 44.376], [59.749, 59.749], [44.376, 57.635]];  // primary outline, 16 points, counter clockwise
void_1 = [[39.908, 35.954], [39.286, 37.575], [38.147, 38.886], [36.628, 39.728], [34.913, 39.999], [33.208, 39.668], [31.72, 38.774], [30.627, 37.424], [30.062, 35.782], [30.092, 34.046], [30.714, 32.425], [31.853, 31.114], [33.372, 30.272], [35.087, 30.001], [36.792, 30.332], [38.28, 31.226], [39.373, 32.576], [39.938, 34.218]];  // centre bore, 18 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
