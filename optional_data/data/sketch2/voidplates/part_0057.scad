$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 3 voids, 110 x 50 x 10 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 110;            // plate length, X
plate_w = 50;             // plate width, Y
plate_t = 10;             // plate thickness, Z
edge_margin = 10;         // wall from the plate edge to any window
windows = 3;              // number of windows in the row
win_l = 15;               // window length
win_w = 10;               // window width
win_pitch = 30;           // window pitch along X
depth_1 = 10;             // depth of void 1 (full thickness = through)
depth_2 = 10;             // depth of void 2 (full thickness = through)
depth_3 = 10;             // depth of void 3 (full thickness = through)
corner_c = 2.5;           // corner chamfer of the plate

profile = [[2.5, 0], [107.5, 0], [110, 2.5], [110, 47.5], [107.5, 50], [2.5, 50], [0, 47.5], [0, 2.5]];  // primary outline, 8 points, counter clockwise
void_1 = [[17.5, 20], [32.5, 20], [32.5, 30], [17.5, 30]];  // window 1 of the row, 4 points
void_2 = [[47.5, 20], [62.5, 20], [62.5, 30], [47.5, 30]];  // window 2 of the row, 4 points
void_3 = [[77.5, 20], [92.5, 20], [92.5, 30], [77.5, 30]];  // window 3 of the row, 4 points

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
