$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 3 voids, 80 x 70 x 5 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 80;             // plate length, X
plate_w = 70;             // plate width, Y
plate_t = 5;              // plate thickness, Z
edge_margin = 10;         // wall from the plate edge to any window
windows = 3;              // number of windows in the row
win_l = 12;               // window length
win_w = 12;               // window width
win_pitch = 20;           // window pitch along X
depth_1 = 2.6;            // depth of void 1 (full thickness = through)
depth_2 = 2.7;            // depth of void 2 (full thickness = through)
depth_3 = 2.3;            // depth of void 3 (full thickness = through)
corner_c = 2;             // corner chamfer of the plate

profile = [[2, 0], [78, 0], [80, 2], [80, 68], [78, 70], [2, 70], [0, 68], [0, 2]];  // primary outline, 8 points, counter clockwise
void_1 = [[14, 29], [26, 29], [26, 41], [14, 41]];  // window 1 of the row, 4 points
void_2 = [[34, 29], [46, 29], [46, 41], [34, 41]];  // window 2 of the row, 4 points
void_3 = [[54, 29], [66, 29], [66, 41], [54, 41]];  // window 3 of the row, 4 points

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
