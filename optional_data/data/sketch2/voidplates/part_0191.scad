$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 3 voids, 90 x 70 x 5 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 90;             // plate length, X
plate_w = 70;             // plate width, Y
plate_t = 5;              // plate thickness, Z
edge_margin = 12;         // wall from the plate edge to any window
windows = 3;              // number of windows in the row
win_l = 15;               // window length
win_w = 10;               // window width
win_pitch = 22;           // window pitch along X
depth_1 = 1.7;            // depth of void 1 (full thickness = through)
depth_2 = 2.4;            // depth of void 2 (full thickness = through)
depth_3 = 2.7;            // depth of void 3 (full thickness = through)
corner_c = 2;             // corner chamfer of the plate

profile = [[2, 0], [88, 0], [90, 2], [90, 68], [88, 70], [2, 70], [0, 68], [0, 2]];  // primary outline, 8 points, counter clockwise
void_1 = [[15.5, 30], [30.5, 30], [30.5, 40], [15.5, 40]];  // window 1 of the row, 4 points
void_2 = [[37.5, 30], [52.5, 30], [52.5, 40], [37.5, 40]];  // window 2 of the row, 4 points
void_3 = [[59.5, 30], [74.5, 30], [74.5, 40], [59.5, 40]];  // window 3 of the row, 4 points

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
