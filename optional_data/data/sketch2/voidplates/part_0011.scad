$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 2 voids, 70 x 50 x 6 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 70;             // plate length, X
plate_w = 50;             // plate width, Y
plate_t = 6;              // plate thickness, Z
edge_margin = 10;         // wall from the plate edge to any window
windows = 2;              // number of windows in the row
win_l = 18;               // window length
win_w = 14;               // window width
win_pitch = 25;           // window pitch along X
depth_1 = 4.2;            // depth of void 1 (full thickness = through)
depth_2 = 3.8;            // depth of void 2 (full thickness = through)
corner_c = 5;             // corner chamfer of the plate

profile = [[5, 0], [65, 0], [70, 5], [70, 45], [65, 50], [5, 50], [0, 45], [0, 5]];  // primary outline, 8 points, counter clockwise
void_1 = [[13.5, 18], [31.5, 18], [31.5, 32], [13.5, 32]];  // window 1 of the row, 4 points
void_2 = [[38.5, 18], [56.5, 18], [56.5, 32], [38.5, 32]];  // window 2 of the row, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
  translate([0, 0, plate_t - depth_2])
    linear_extrude(height = depth_2 + 1) polygon(points = void_2);
}
