$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 3 voids, 80 x 50 x 8 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 80;             // plate length, X
plate_w = 50;             // plate width, Y
plate_t = 8;              // plate thickness, Z
edge_margin = 12;         // wall from the plate edge to any window
windows = 3;              // number of windows in the row
win_l = 15;               // window length
win_w = 12;               // window width
win_pitch = 18.7;         // window pitch along X
depth_1 = 2.8;            // depth of void 1 (full thickness = through)
depth_2 = 5.1;            // depth of void 2 (full thickness = through)
depth_3 = 3.9;            // depth of void 3 (full thickness = through)
corner_c = 5;             // corner chamfer of the plate

profile = [[5, 0], [75, 0], [80, 5], [80, 45], [75, 50], [5, 50], [0, 45], [0, 5]];  // primary outline, 8 points, counter clockwise
void_1 = [[13.85, 19], [28.85, 19], [28.85, 31], [13.85, 31]];  // window 1 of the row, 4 points
void_2 = [[32.55, 19], [47.55, 19], [47.55, 31], [32.55, 31]];  // window 2 of the row, 4 points
void_3 = [[51.25, 19], [66.25, 19], [66.25, 31], [51.25, 31]];  // window 3 of the row, 4 points

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
