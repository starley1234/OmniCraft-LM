$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 3 voids, 120 x 60 x 10 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 120;            // plate length, X
plate_w = 60;             // plate width, Y
plate_t = 10;             // plate thickness, Z
edge_margin = 8;          // wall from the plate edge to any window
windows = 3;              // number of windows in the row
win_l = 18;               // window length
win_w = 10;               // window width
win_pitch = 34.7;         // window pitch along X
depth_1 = 10;             // depth of void 1 (full thickness = through)
depth_2 = 10;             // depth of void 2 (full thickness = through)
depth_3 = 10;             // depth of void 3 (full thickness = through)
corner_c = 4;             // corner chamfer of the plate

profile = [[4, 0], [116, 0], [120, 4], [120, 56], [116, 60], [4, 60], [0, 56], [0, 4]];  // primary outline, 8 points, counter clockwise
void_1 = [[16.35, 25], [34.35, 25], [34.35, 35], [16.35, 35]];  // window 1 of the row, 4 points
void_2 = [[51.05, 25], [69.05, 25], [69.05, 35], [51.05, 35]];  // window 2 of the row, 4 points
void_3 = [[85.75, 25], [103.75, 25], [103.75, 35], [85.75, 35]];  // window 3 of the row, 4 points

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
