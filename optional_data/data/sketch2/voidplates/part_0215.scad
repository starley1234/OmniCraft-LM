$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 3 voids, 100 x 70 x 6 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 100;            // plate length, X
plate_w = 70;             // plate width, Y
plate_t = 6;              // plate thickness, Z
edge_margin = 8;          // wall from the plate edge to any window
windows = 3;              // number of windows in the row
win_l = 15;               // window length
win_w = 10;               // window width
win_pitch = 28;           // window pitch along X
depth_1 = 6;              // depth of void 1 (full thickness = through)
depth_2 = 6;              // depth of void 2 (full thickness = through)
depth_3 = 6;              // depth of void 3 (full thickness = through)
corner_c = 2.5;           // corner chamfer of the plate

profile = [[2.5, 0], [97.5, 0], [100, 2.5], [100, 67.5], [97.5, 70], [2.5, 70], [0, 67.5], [0, 2.5]];  // primary outline, 8 points, counter clockwise
void_1 = [[14.5, 30], [29.5, 30], [29.5, 40], [14.5, 40]];  // window 1 of the row, 4 points
void_2 = [[42.5, 30], [57.5, 30], [57.5, 40], [42.5, 40]];  // window 2 of the row, 4 points
void_3 = [[70.5, 30], [85.5, 30], [85.5, 40], [70.5, 40]];  // window 3 of the row, 4 points

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
