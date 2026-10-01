$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 3 voids, 100 x 50 x 6 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 100;            // plate length, X
plate_w = 50;             // plate width, Y
plate_t = 6;              // plate thickness, Z
edge_margin = 10;         // wall from the plate edge to any window
windows = 3;              // number of windows in the row
win_l = 12;               // window length
win_w = 10;               // window width
win_pitch = 26.7;         // window pitch along X
depth_1 = 2;              // depth of void 1 (full thickness = through)
depth_2 = 2.4;            // depth of void 2 (full thickness = through)
depth_3 = 4.5;            // depth of void 3 (full thickness = through)
corner_c = 5;             // corner chamfer of the plate

profile = [[5, 0], [95, 0], [100, 5], [100, 45], [95, 50], [5, 50], [0, 45], [0, 5]];  // primary outline, 8 points, counter clockwise
void_1 = [[17.35, 20], [29.35, 20], [29.35, 30], [17.35, 30]];  // window 1 of the row, 4 points
void_2 = [[44.05, 20], [56.05, 20], [56.05, 30], [44.05, 30]];  // window 2 of the row, 4 points
void_3 = [[70.75, 20], [82.75, 20], [82.75, 30], [70.75, 30]];  // window 3 of the row, 4 points

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
