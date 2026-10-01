$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 2 voids, 120 x 45 x 6 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 120;            // plate length, X
plate_w = 45;             // plate width, Y
plate_t = 6;              // plate thickness, Z
edge_margin = 10;         // wall from the plate edge to any window
windows = 2;              // number of windows in the row
win_l = 22;               // window length
win_w = 10;               // window width
win_pitch = 50;           // window pitch along X
depth_1 = 6;              // depth of void 1 (full thickness = through)
depth_2 = 6;              // depth of void 2 (full thickness = through)
corner_c = 2;             // corner chamfer of the plate
fit_tol = 0.1;            // declared fit tolerance (prompt contract)
free_tol = 0.5;           // declared free tolerance (prompt contract)

profile = [[2, 0], [118, 0], [120, 2], [120, 43], [118, 45], [2, 45], [0, 43], [0, 2]];  // primary outline, 8 points, counter clockwise
void_1 = [[24, 17.5], [46, 17.5], [46, 27.5], [24, 27.5]];  // window 1 of the row, 4 points
void_2 = [[74, 17.5], [96, 17.5], [96, 27.5], [74, 27.5]];  // window 2 of the row, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_2);
}
