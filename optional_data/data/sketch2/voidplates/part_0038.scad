$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 3 voids, 120 x 80 x 5 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 120;            // plate length, X
plate_w = 80;             // plate width, Y
plate_t = 5;              // plate thickness, Z
edge_margin = 8;          // wall from the plate edge to any window
windows = 3;              // number of windows in the row
win_l = 12;               // window length
win_w = 14;               // window width
win_pitch = 34.7;         // window pitch along X
depth_1 = 2.9;            // depth of void 1 (full thickness = through)
depth_2 = 2;              // depth of void 2 (full thickness = through)
depth_3 = 2.8;            // depth of void 3 (full thickness = through)
corner_c = 3;             // corner chamfer of the plate
fit_tol = 0.1;            // declared fit tolerance (prompt contract)
free_tol = 0.5;           // declared free tolerance (prompt contract)

profile = [[3, 0], [117, 0], [120, 3], [120, 77], [117, 80], [3, 80], [0, 77], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[19.35, 33], [31.35, 33], [31.35, 47], [19.35, 47]];  // window 1 of the row, 4 points
void_2 = [[54.05, 33], [66.05, 33], [66.05, 47], [54.05, 47]];  // window 2 of the row, 4 points
void_3 = [[88.75, 33], [100.75, 33], [100.75, 47], [88.75, 47]];  // window 3 of the row, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
  translate([0, 0, plate_t - depth_2])
    linear_extrude(height = depth_2 + 1) polygon(points = void_2);
  translate([0, 0, plate_t - depth_3])
    linear_extrude(height = depth_3 + 1) polygon(points = void_3);
}
