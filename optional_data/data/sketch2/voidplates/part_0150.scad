$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 2 voids, 80 x 80 x 6 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 80;             // plate length, X
plate_w = 80;             // plate width, Y
plate_t = 6;              // plate thickness, Z
edge_margin = 12;         // wall from the plate edge to any window
windows = 2;              // number of windows in the row
win_l = 22;               // window length
win_w = 12;               // window width
win_pitch = 28;           // window pitch along X
depth_1 = 6;              // depth of void 1 (full thickness = through)
depth_2 = 6;              // depth of void 2 (full thickness = through)
corner_c = 3;             // corner chamfer of the plate

profile = [[3, 0], [77, 0], [80, 3], [80, 77], [77, 80], [3, 80], [0, 77], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[15, 34], [37, 34], [37, 46], [15, 46]];  // window 1 of the row, 4 points
void_2 = [[43, 34], [65, 34], [65, 46], [43, 46]];  // window 2 of the row, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_2);
}
