$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 2 voids, 120 x 80 x 8 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 120;            // plate length, X
plate_w = 80;             // plate width, Y
plate_t = 8;              // plate thickness, Z
edge_margin = 10;         // wall from the plate edge to any window
windows = 2;              // number of windows in the row
win_l = 12;               // window length
win_w = 12;               // window width
win_pitch = 50;           // window pitch along X
depth_1 = 8;              // depth of void 1 (full thickness = through)
depth_2 = 2.1;            // depth of void 2 (full thickness = through)
corner_c = 3;             // corner chamfer of the plate

profile = [[3, 0], [117, 0], [120, 3], [120, 77], [117, 80], [3, 80], [0, 77], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[29, 34], [41, 34], [41, 46], [29, 46]];  // window 1 of the row, 4 points
void_2 = [[79, 34], [91, 34], [91, 46], [79, 46]];  // window 2 of the row, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
  translate([0, 0, plate_t - depth_2])
    linear_extrude(height = depth_2 + 1) polygon(points = void_2);
}
