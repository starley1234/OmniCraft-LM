$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 2 voids, 90 x 70 x 8 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 90;             // plate length, X
plate_w = 70;             // plate width, Y
plate_t = 8;              // plate thickness, Z
edge_margin = 12;         // wall from the plate edge to any window
windows = 2;              // number of windows in the row
win_l = 12;               // window length
win_w = 12;               // window width
win_pitch = 33;           // window pitch along X
depth_1 = 2.6;            // depth of void 1 (full thickness = through)
depth_2 = 2.1;            // depth of void 2 (full thickness = through)
corner_c = 4;             // corner chamfer of the plate

profile = [[4, 0], [86, 0], [90, 4], [90, 66], [86, 70], [4, 70], [0, 66], [0, 4]];  // primary outline, 8 points, counter clockwise
void_1 = [[22.5, 29], [34.5, 29], [34.5, 41], [22.5, 41]];  // window 1 of the row, 4 points
void_2 = [[55.5, 29], [67.5, 29], [67.5, 41], [55.5, 41]];  // window 2 of the row, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
  translate([0, 0, plate_t - depth_2])
    linear_extrude(height = depth_2 + 1) polygon(points = void_2);
}
