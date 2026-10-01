$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 3 voids, 100 x 70 x 8 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 100;            // plate length, X
plate_w = 70;             // plate width, Y
plate_t = 8;              // plate thickness, Z
edge_margin = 10;         // wall from the plate edge to any window
windows = 3;              // number of windows in the row
win_l = 22;               // window length
win_w = 10;               // window width
win_pitch = 26.7;         // window pitch along X
depth_1 = 2.8;            // depth of void 1 (full thickness = through)
depth_2 = 3.8;            // depth of void 2 (full thickness = through)
depth_3 = 4.8;            // depth of void 3 (full thickness = through)
corner_c = 5;             // corner chamfer of the plate

profile = [[5, 0], [95, 0], [100, 5], [100, 65], [95, 70], [5, 70], [0, 65], [0, 5]];  // primary outline, 8 points, counter clockwise
void_1 = [[12.35, 30], [34.35, 30], [34.35, 40], [12.35, 40]];  // window 1 of the row, 4 points
void_2 = [[39.05, 30], [61.05, 30], [61.05, 40], [39.05, 40]];  // window 2 of the row, 4 points
void_3 = [[65.75, 30], [87.75, 30], [87.75, 40], [65.75, 40]];  // window 3 of the row, 4 points

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
