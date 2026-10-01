$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 2 voids, 120 x 70 x 5 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 120;            // plate length, X
plate_w = 70;             // plate width, Y
plate_t = 5;              // plate thickness, Z
edge_margin = 10;         // wall from the plate edge to any window
windows = 2;              // number of windows in the row
win_l = 15;               // window length
win_w = 12;               // window width
win_pitch = 50;           // window pitch along X
depth_1 = 5;              // depth of void 1 (full thickness = through)
depth_2 = 5;              // depth of void 2 (full thickness = through)
corner_c = 2.5;           // corner chamfer of the plate

profile = [[2.5, 0], [117.5, 0], [120, 2.5], [120, 67.5], [117.5, 70], [2.5, 70], [0, 67.5], [0, 2.5]];  // primary outline, 8 points, counter clockwise
void_1 = [[27.5, 29], [42.5, 29], [42.5, 41], [27.5, 41]];  // window 1 of the row, 4 points
void_2 = [[77.5, 29], [92.5, 29], [92.5, 41], [77.5, 41]];  // window 2 of the row, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_2);
}
