$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 2 voids, 70 x 50 x 8 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 70;             // plate length, X
plate_w = 50;             // plate width, Y
plate_t = 8;              // plate thickness, Z
edge_margin = 8;          // wall from the plate edge to any window
windows = 2;              // number of windows in the row
win_l = 22;               // window length
win_w = 12;               // window width
win_pitch = 27;           // window pitch along X
depth_1 = 4.1;            // depth of void 1 (full thickness = through)
depth_2 = 5.7;            // depth of void 2 (full thickness = through)
corner_c = 4;             // corner chamfer of the plate

profile = [[4, 0], [66, 0], [70, 4], [70, 46], [66, 50], [4, 50], [0, 46], [0, 4]];  // primary outline, 8 points, counter clockwise
void_1 = [[10.5, 19], [32.5, 19], [32.5, 31], [10.5, 31]];  // window 1 of the row, 4 points
void_2 = [[37.5, 19], [59.5, 19], [59.5, 31], [37.5, 31]];  // window 2 of the row, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
  translate([0, 0, plate_t - depth_2])
    linear_extrude(height = depth_2 + 1) polygon(points = void_2);
}
