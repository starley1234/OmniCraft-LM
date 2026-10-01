$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 3 voids, 120 x 50 x 5 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 120;            // plate length, X
plate_w = 50;             // plate width, Y
plate_t = 5;              // plate thickness, Z
edge_margin = 12;         // wall from the plate edge to any window
windows = 3;              // number of windows in the row
win_l = 12;               // window length
win_w = 14;               // window width
win_pitch = 32;           // window pitch along X
depth_1 = 5;              // depth of void 1 (full thickness = through)
depth_2 = 5;              // depth of void 2 (full thickness = through)
depth_3 = 5;              // depth of void 3 (full thickness = through)
corner_c = 5;             // corner chamfer of the plate

profile = [[5, 0], [115, 0], [120, 5], [120, 45], [115, 50], [5, 50], [0, 45], [0, 5]];  // primary outline, 8 points, counter clockwise
void_1 = [[22, 18], [34, 18], [34, 32], [22, 32]];  // window 1 of the row, 4 points
void_2 = [[54, 18], [66, 18], [66, 32], [54, 32]];  // window 2 of the row, 4 points
void_3 = [[86, 18], [98, 18], [98, 32], [86, 32]];  // window 3 of the row, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_2);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_3);
}
