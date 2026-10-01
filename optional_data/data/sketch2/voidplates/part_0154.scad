$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 2 voids, 90 x 45 x 10 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 90;             // plate length, X
plate_w = 45;             // plate width, Y
plate_t = 10;             // plate thickness, Z
edge_margin = 8;          // wall from the plate edge to any window
windows = 2;              // number of windows in the row
win_l = 15;               // window length
win_w = 14;               // window width
win_pitch = 37;           // window pitch along X
depth_1 = 7.7;            // depth of void 1 (full thickness = through)
depth_2 = 5.8;            // depth of void 2 (full thickness = through)
corner_c = 4;             // corner chamfer of the plate

profile = [[4, 0], [86, 0], [90, 4], [90, 41], [86, 45], [4, 45], [0, 41], [0, 4]];  // primary outline, 8 points, counter clockwise
void_1 = [[19, 15.5], [34, 15.5], [34, 29.5], [19, 29.5]];  // window 1 of the row, 4 points
void_2 = [[56, 15.5], [71, 15.5], [71, 29.5], [56, 29.5]];  // window 2 of the row, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
  translate([0, 0, plate_t - depth_2])
    linear_extrude(height = depth_2 + 1) polygon(points = void_2);
}
