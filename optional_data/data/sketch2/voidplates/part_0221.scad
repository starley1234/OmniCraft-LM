$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 2 voids, 80 x 60 x 6 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 80;             // plate length, X
plate_w = 60;             // plate width, Y
plate_t = 6;              // plate thickness, Z
edge_margin = 10;         // wall from the plate edge to any window
windows = 2;              // number of windows in the row
win_l = 15;               // window length
win_w = 10;               // window width
win_pitch = 30;           // window pitch along X
depth_1 = 6;              // depth of void 1 (full thickness = through)
depth_2 = 1.6;            // depth of void 2 (full thickness = through)
corner_c = 2.5;           // corner chamfer of the plate

profile = [[2.5, 0], [77.5, 0], [80, 2.5], [80, 57.5], [77.5, 60], [2.5, 60], [0, 57.5], [0, 2.5]];  // primary outline, 8 points, counter clockwise
void_1 = [[17.5, 25], [32.5, 25], [32.5, 35], [17.5, 35]];  // window 1 of the row, 4 points
void_2 = [[47.5, 25], [62.5, 25], [62.5, 35], [47.5, 35]];  // window 2 of the row, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
  translate([0, 0, plate_t - depth_2])
    linear_extrude(height = depth_2 + 1) polygon(points = void_2);
}
