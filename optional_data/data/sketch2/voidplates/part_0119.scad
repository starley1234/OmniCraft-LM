$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 2 voids, 100 x 70 x 5 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 100;            // plate length, X
plate_w = 70;             // plate width, Y
plate_t = 5;              // plate thickness, Z
edge_margin = 12;         // wall from the plate edge to any window
windows = 2;              // number of windows in the row
win_l = 22;               // window length
win_w = 14;               // window width
win_pitch = 38;           // window pitch along X
depth_1 = 5;              // depth of void 1 (full thickness = through)
depth_2 = 5;              // depth of void 2 (full thickness = through)
corner_c = 2;             // corner chamfer of the plate

profile = [[2, 0], [98, 0], [100, 2], [100, 68], [98, 70], [2, 70], [0, 68], [0, 2]];  // primary outline, 8 points, counter clockwise
void_1 = [[20, 28], [42, 28], [42, 42], [20, 42]];  // window 1 of the row, 4 points
void_2 = [[58, 28], [80, 28], [80, 42], [58, 42]];  // window 2 of the row, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_2);
}
