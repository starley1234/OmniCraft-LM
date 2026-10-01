$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 2 voids, 100 x 70 x 6 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 100;            // plate length, X
plate_w = 70;             // plate width, Y
plate_t = 6;              // plate thickness, Z
edge_margin = 10;         // wall from the plate edge to any window
windows = 2;              // number of windows in the row
win_l = 12;               // window length
win_w = 10;               // window width
win_pitch = 40;           // window pitch along X
depth_1 = 6;              // depth of void 1 (full thickness = through)
depth_2 = 2.1;            // depth of void 2 (full thickness = through)
corner_c = 3;             // corner chamfer of the plate

profile = [[3, 0], [97, 0], [100, 3], [100, 67], [97, 70], [3, 70], [0, 67], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[24, 30], [36, 30], [36, 40], [24, 40]];  // window 1 of the row, 4 points
void_2 = [[64, 30], [76, 30], [76, 40], [64, 40]];  // window 2 of the row, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
  translate([0, 0, plate_t - depth_2])
    linear_extrude(height = depth_2 + 1) polygon(points = void_2);
}
