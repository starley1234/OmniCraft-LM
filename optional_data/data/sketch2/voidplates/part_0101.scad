$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 3 voids, 90 x 45 x 5 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 90;             // plate length, X
plate_w = 45;             // plate width, Y
plate_t = 5;              // plate thickness, Z
edge_margin = 8;          // wall from the plate edge to any window
windows = 3;              // number of windows in the row
win_l = 15;               // window length
win_w = 10;               // window width
win_pitch = 24.7;         // window pitch along X
depth_1 = 5;              // depth of void 1 (full thickness = through)
depth_2 = 5;              // depth of void 2 (full thickness = through)
depth_3 = 5;              // depth of void 3 (full thickness = through)
corner_c = 4;             // corner chamfer of the plate

profile = [[4, 0], [86, 0], [90, 4], [90, 41], [86, 45], [4, 45], [0, 41], [0, 4]];  // primary outline, 8 points, counter clockwise
void_1 = [[12.85, 17.5], [27.85, 17.5], [27.85, 27.5], [12.85, 27.5]];  // window 1 of the row, 4 points
void_2 = [[37.55, 17.5], [52.55, 17.5], [52.55, 27.5], [37.55, 27.5]];  // window 2 of the row, 4 points
void_3 = [[62.25, 17.5], [77.25, 17.5], [77.25, 27.5], [62.25, 27.5]];  // window 3 of the row, 4 points

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
