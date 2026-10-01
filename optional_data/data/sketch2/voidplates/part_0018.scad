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
win_l = 12;               // window length
win_w = 12;               // window width
win_pitch = 34.7;         // window pitch along X
depth_1 = 7.5;            // depth of void 1 (full thickness = through)
depth_2 = 10;             // depth of void 2 (full thickness = through)
depth_3 = 7.5;            // depth of void 3 (full thickness = through)
corner_c = 2;             // corner chamfer of the plate

profile = [[2, 0], [118, 0], [120, 2], [120, 58], [118, 60], [2, 60], [0, 58], [0, 2]];  // primary outline, 8 points, counter clockwise
void_1 = [[19.35, 24], [31.35, 24], [31.35, 36], [19.35, 36]];  // window 1 of the row, 4 points
void_2 = [[54.05, 24], [66.05, 24], [66.05, 36], [54.05, 36]];  // window 2 of the row, 4 points
void_3 = [[88.75, 24], [100.75, 24], [100.75, 36], [88.75, 36]];  // window 3 of the row, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_2);
  translate([0, 0, plate_t - depth_3])
    linear_extrude(height = depth_3 + 1) polygon(points = void_3);
}
