$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 3 voids, 100 x 50 x 10 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 100;            // plate length, X
plate_w = 50;             // plate width, Y
plate_t = 10;             // plate thickness, Z
edge_margin = 8;          // wall from the plate edge to any window
windows = 3;              // number of windows in the row
win_l = 15;               // window length
win_w = 14;               // window width
win_pitch = 28;           // window pitch along X
depth_1 = 10;             // depth of void 1 (full thickness = through)
depth_2 = 10;             // depth of void 2 (full thickness = through)
depth_3 = 10;             // depth of void 3 (full thickness = through)
corner_c = 5;             // corner chamfer of the plate

profile = [[5, 0], [95, 0], [100, 5], [100, 45], [95, 50], [5, 50], [0, 45], [0, 5]];  // primary outline, 8 points, counter clockwise
void_1 = [[14.5, 18], [29.5, 18], [29.5, 32], [14.5, 32]];  // window 1 of the row, 4 points
void_2 = [[42.5, 18], [57.5, 18], [57.5, 32], [42.5, 32]];  // window 2 of the row, 4 points
void_3 = [[70.5, 18], [85.5, 18], [85.5, 32], [70.5, 32]];  // window 3 of the row, 4 points

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
