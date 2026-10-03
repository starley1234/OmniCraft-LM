$fn = 32;
// target_bbox: 90, 70, 5
// ----------------------------------------------------------------------
// Windowed plate: 3 voids, 90 x 70 x 5 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 90;             // plate length, X
plate_w = 70;             // plate width, Y
plate_t = 5;              // plate thickness, Z
edge_margin = 10;         // wall from the plate edge to any window
windows = 3;              // number of windows in the row
win_l = 12;               // window length
win_w = 14;               // window width
win_pitch = 23.3;         // window pitch along X
depth_1 = 5;              // depth of void 1 (full thickness = through)
depth_2 = 3.3;            // depth of void 2 (full thickness = through)
depth_3 = 3.2;            // depth of void 3 (full thickness = through)
corner_c = 2.5;           // corner chamfer of the plate

profile = [[2.5, 0], [87.5, 0], [90, 2.5], [90, 67.5], [87.5, 70], [2.5, 70], [0, 67.5], [0, 2.5]];  // primary outline, 8 points, counter clockwise
void_1 = [[15.65, 28], [27.65, 28], [27.65, 42], [15.65, 42]];  // window 1 of the row, 4 points
void_2 = [[38.95, 28], [50.95, 28], [50.95, 42], [38.95, 42]];  // window 2 of the row, 4 points
void_3 = [[62.25, 28], [74.25, 28], [74.25, 42], [62.25, 42]];  // window 3 of the row, 4 points

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
