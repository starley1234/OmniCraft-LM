$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 3 voids, 100 x 45 x 10 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 100;            // plate length, X
plate_w = 45;             // plate width, Y
plate_t = 10;             // plate thickness, Z
edge_margin = 8;          // wall from the plate edge to any window
windows = 3;              // number of windows in the row
win_l = 18;               // window length
win_w = 12;               // window width
win_pitch = 28;           // window pitch along X
depth_1 = 6.3;            // depth of void 1 (full thickness = through)
depth_2 = 3.3;            // depth of void 2 (full thickness = through)
depth_3 = 4.8;            // depth of void 3 (full thickness = through)
corner_c = 2.5;           // corner chamfer of the plate

profile = [[2.5, 0], [97.5, 0], [100, 2.5], [100, 42.5], [97.5, 45], [2.5, 45], [0, 42.5], [0, 2.5]];  // primary outline, 8 points, counter clockwise
void_1 = [[13, 16.5], [31, 16.5], [31, 28.5], [13, 28.5]];  // window 1 of the row, 4 points
void_2 = [[41, 16.5], [59, 16.5], [59, 28.5], [41, 28.5]];  // window 2 of the row, 4 points
void_3 = [[69, 16.5], [87, 16.5], [87, 28.5], [69, 28.5]];  // window 3 of the row, 4 points

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
