$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 2 voids, 100 x 45 x 5 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 100;            // plate length, X
plate_w = 45;             // plate width, Y
plate_t = 5;              // plate thickness, Z
edge_margin = 12;         // wall from the plate edge to any window
windows = 2;              // number of windows in the row
win_l = 18;               // window length
win_w = 10;               // window width
win_pitch = 38;           // window pitch along X
depth_1 = 2.4;            // depth of void 1 (full thickness = through)
depth_2 = 1.6;            // depth of void 2 (full thickness = through)
corner_c = 5;             // corner chamfer of the plate

profile = [[5, 0], [95, 0], [100, 5], [100, 40], [95, 45], [5, 45], [0, 40], [0, 5]];  // primary outline, 8 points, counter clockwise
void_1 = [[22, 17.5], [40, 17.5], [40, 27.5], [22, 27.5]];  // window 1 of the row, 4 points
void_2 = [[60, 17.5], [78, 17.5], [78, 27.5], [60, 27.5]];  // window 2 of the row, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
  translate([0, 0, plate_t - depth_2])
    linear_extrude(height = depth_2 + 1) polygon(points = void_2);
}
