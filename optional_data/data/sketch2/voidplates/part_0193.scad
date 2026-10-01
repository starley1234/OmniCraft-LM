$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 3 voids, 120 x 80 x 10 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 120;            // plate length, X
plate_w = 80;             // plate width, Y
plate_t = 10;             // plate thickness, Z
edge_margin = 8;          // wall from the plate edge to any window
windows = 3;              // number of windows in the row
win_l = 15;               // window length
win_w = 12;               // window width
win_pitch = 34.7;         // window pitch along X
depth_1 = 5.1;            // depth of void 1 (full thickness = through)
depth_2 = 10;             // depth of void 2 (full thickness = through)
depth_3 = 10;             // depth of void 3 (full thickness = through)
corner_c = 2.5;           // corner chamfer of the plate

profile = [[2.5, 0], [117.5, 0], [120, 2.5], [120, 77.5], [117.5, 80], [2.5, 80], [0, 77.5], [0, 2.5]];  // primary outline, 8 points, counter clockwise
void_1 = [[17.85, 34], [32.85, 34], [32.85, 46], [17.85, 46]];  // window 1 of the row, 4 points
void_2 = [[52.55, 34], [67.55, 34], [67.55, 46], [52.55, 46]];  // window 2 of the row, 4 points
void_3 = [[87.25, 34], [102.25, 34], [102.25, 46], [87.25, 46]];  // window 3 of the row, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_2);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_3);
}
