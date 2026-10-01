$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 2 voids, 70 x 70 x 10 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 70;             // plate length, X
plate_w = 70;             // plate width, Y
plate_t = 10;             // plate thickness, Z
edge_margin = 8;          // wall from the plate edge to any window
windows = 2;              // number of windows in the row
win_l = 15;               // window length
win_w = 14;               // window width
win_pitch = 27;           // window pitch along X
depth_1 = 10;             // depth of void 1 (full thickness = through)
depth_2 = 10;             // depth of void 2 (full thickness = through)
corner_c = 4;             // corner chamfer of the plate

profile = [[4, 0], [66, 0], [70, 4], [70, 66], [66, 70], [4, 70], [0, 66], [0, 4]];  // primary outline, 8 points, counter clockwise
void_1 = [[14, 28], [29, 28], [29, 42], [14, 42]];  // window 1 of the row, 4 points
void_2 = [[41, 28], [56, 28], [56, 42], [41, 42]];  // window 2 of the row, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_2);
}
