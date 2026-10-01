$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 3 voids, 110 x 60 x 6 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 110;            // plate length, X
plate_w = 60;             // plate width, Y
plate_t = 6;              // plate thickness, Z
edge_margin = 10;         // wall from the plate edge to any window
windows = 3;              // number of windows in the row
win_l = 22;               // window length
win_w = 10;               // window width
win_pitch = 30;           // window pitch along X
depth_1 = 6;              // depth of void 1 (full thickness = through)
depth_2 = 3.2;            // depth of void 2 (full thickness = through)
depth_3 = 3.1;            // depth of void 3 (full thickness = through)
corner_c = 2;             // corner chamfer of the plate

profile = [[2, 0], [108, 0], [110, 2], [110, 58], [108, 60], [2, 60], [0, 58], [0, 2]];  // primary outline, 8 points, counter clockwise
void_1 = [[14, 25], [36, 25], [36, 35], [14, 35]];  // window 1 of the row, 4 points
void_2 = [[44, 25], [66, 25], [66, 35], [44, 35]];  // window 2 of the row, 4 points
void_3 = [[74, 25], [96, 25], [96, 35], [74, 35]];  // window 3 of the row, 4 points

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
