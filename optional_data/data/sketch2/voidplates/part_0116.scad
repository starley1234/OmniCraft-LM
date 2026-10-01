$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 3 voids, 120 x 50 x 5 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 120;            // plate length, X
plate_w = 50;             // plate width, Y
plate_t = 5;              // plate thickness, Z
edge_margin = 8;          // wall from the plate edge to any window
windows = 3;              // number of windows in the row
win_l = 15;               // window length
win_w = 12;               // window width
win_pitch = 34.7;         // window pitch along X
depth_1 = 5;              // depth of void 1 (full thickness = through)
depth_2 = 2.7;            // depth of void 2 (full thickness = through)
depth_3 = 1.9;            // depth of void 3 (full thickness = through)
corner_c = 4;             // corner chamfer of the plate

profile = [[4, 0], [116, 0], [120, 4], [120, 46], [116, 50], [4, 50], [0, 46], [0, 4]];  // primary outline, 8 points, counter clockwise
void_1 = [[17.85, 19], [32.85, 19], [32.85, 31], [17.85, 31]];  // window 1 of the row, 4 points
void_2 = [[52.55, 19], [67.55, 19], [67.55, 31], [52.55, 31]];  // window 2 of the row, 4 points
void_3 = [[87.25, 19], [102.25, 19], [102.25, 31], [87.25, 31]];  // window 3 of the row, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
  translate([0, 0, plate_t - depth_2])
    linear_extrude(height = depth_2 + 1) polygon(points = void_2);
  translate([0, 0, plate_t - depth_3])
    linear_extrude(height = depth_3 + 1) polygon(points = void_3);
}
