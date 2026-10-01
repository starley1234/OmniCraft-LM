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
win_l = 12;               // window length
win_w = 10;               // window width
win_pitch = 24.7;         // window pitch along X
depth_1 = 1.6;            // depth of void 1 (full thickness = through)
depth_2 = 2.1;            // depth of void 2 (full thickness = through)
depth_3 = 2.4;            // depth of void 3 (full thickness = through)
corner_c = 5;             // corner chamfer of the plate

profile = [[5, 0], [85, 0], [90, 5], [90, 40], [85, 45], [5, 45], [0, 40], [0, 5]];  // primary outline, 8 points, counter clockwise
void_1 = [[14.35, 17.5], [26.35, 17.5], [26.35, 27.5], [14.35, 27.5]];  // window 1 of the row, 4 points
void_2 = [[39.05, 17.5], [51.05, 17.5], [51.05, 27.5], [39.05, 27.5]];  // window 2 of the row, 4 points
void_3 = [[63.75, 17.5], [75.75, 17.5], [75.75, 27.5], [63.75, 27.5]];  // window 3 of the row, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
  translate([0, 0, plate_t - depth_2])
    linear_extrude(height = depth_2 + 1) polygon(points = void_2);
  translate([0, 0, plate_t - depth_3])
    linear_extrude(height = depth_3 + 1) polygon(points = void_3);
}
