$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 2 voids, 110 x 50 x 10 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 110;            // plate length, X
plate_w = 50;             // plate width, Y
plate_t = 10;             // plate thickness, Z
edge_margin = 10;         // wall from the plate edge to any window
windows = 2;              // number of windows in the row
win_l = 15;               // window length
win_w = 10;               // window width
win_pitch = 45;           // window pitch along X
depth_1 = 10;             // depth of void 1 (full thickness = through)
depth_2 = 10;             // depth of void 2 (full thickness = through)
corner_c = 5;             // corner chamfer of the plate

profile = [[5, 0], [105, 0], [110, 5], [110, 45], [105, 50], [5, 50], [0, 45], [0, 5]];  // primary outline, 8 points, counter clockwise
void_1 = [[25, 20], [40, 20], [40, 30], [25, 30]];  // window 1 of the row, 4 points
void_2 = [[70, 20], [85, 20], [85, 30], [70, 30]];  // window 2 of the row, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_2);
}
