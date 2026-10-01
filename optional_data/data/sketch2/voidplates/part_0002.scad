$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 3 voids, 90 x 45 x 10 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 90;             // plate length, X
plate_w = 45;             // plate width, Y
plate_t = 10;             // plate thickness, Z
edge_margin = 8;          // wall from the plate edge to any window
windows = 3;              // number of windows in the row
win_l = 18;               // window length
win_w = 12;               // window width
win_pitch = 24.7;         // window pitch along X
depth_1 = 10;             // depth of void 1 (full thickness = through)
depth_2 = 10;             // depth of void 2 (full thickness = through)
depth_3 = 10;             // depth of void 3 (full thickness = through)
corner_c = 5;             // corner chamfer of the plate

profile = [[5, 0], [85, 0], [90, 5], [90, 40], [85, 45], [5, 45], [0, 40], [0, 5]];  // primary outline, 8 points, counter clockwise
void_1 = [[11.35, 16.5], [29.35, 16.5], [29.35, 28.5], [11.35, 28.5]];  // window 1 of the row, 4 points
void_2 = [[36.05, 16.5], [54.05, 16.5], [54.05, 28.5], [36.05, 28.5]];  // window 2 of the row, 4 points
void_3 = [[60.75, 16.5], [78.75, 16.5], [78.75, 28.5], [60.75, 28.5]];  // window 3 of the row, 4 points

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
