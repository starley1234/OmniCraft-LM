$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 2 voids, 70 x 80 x 8 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 70;             // plate length, X
plate_w = 80;             // plate width, Y
plate_t = 8;              // plate thickness, Z
edge_margin = 8;          // wall from the plate edge to any window
windows = 2;              // number of windows in the row
win_l = 15;               // window length
win_w = 12;               // window width
win_pitch = 27;           // window pitch along X
depth_1 = 8;              // depth of void 1 (full thickness = through)
depth_2 = 8;              // depth of void 2 (full thickness = through)
corner_c = 2.5;           // corner chamfer of the plate

profile = [[2.5, 0], [67.5, 0], [70, 2.5], [70, 77.5], [67.5, 80], [2.5, 80], [0, 77.5], [0, 2.5]];  // primary outline, 8 points, counter clockwise
void_1 = [[14, 34], [29, 34], [29, 46], [14, 46]];  // window 1 of the row, 4 points
void_2 = [[41, 34], [56, 34], [56, 46], [41, 46]];  // window 2 of the row, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_2);
}
