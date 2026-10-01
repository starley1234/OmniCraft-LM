$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 3 voids, 80 x 60 x 5 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 80;             // plate length, X
plate_w = 60;             // plate width, Y
plate_t = 5;              // plate thickness, Z
edge_margin = 8;          // wall from the plate edge to any window
windows = 3;              // number of windows in the row
win_l = 18;               // window length
win_w = 10;               // window width
win_pitch = 21.3;         // window pitch along X
depth_1 = 3.3;            // depth of void 1 (full thickness = through)
depth_2 = 5;              // depth of void 2 (full thickness = through)
depth_3 = 2.1;            // depth of void 3 (full thickness = through)
corner_c = 4;             // corner chamfer of the plate

profile = [[4, 0], [76, 0], [80, 4], [80, 56], [76, 60], [4, 60], [0, 56], [0, 4]];  // primary outline, 8 points, counter clockwise
void_1 = [[9.65, 25], [27.65, 25], [27.65, 35], [9.65, 35]];  // window 1 of the row, 4 points
void_2 = [[30.95, 25], [48.95, 25], [48.95, 35], [30.95, 35]];  // window 2 of the row, 4 points
void_3 = [[52.25, 25], [70.25, 25], [70.25, 35], [52.25, 35]];  // window 3 of the row, 4 points

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
