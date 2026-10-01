$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 3 voids, 80 x 45 x 10 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 80;             // plate length, X
plate_w = 45;             // plate width, Y
plate_t = 10;             // plate thickness, Z
edge_margin = 8;          // wall from the plate edge to any window
windows = 3;              // number of windows in the row
win_l = 12;               // window length
win_w = 12;               // window width
win_pitch = 21.3;         // window pitch along X
depth_1 = 4.9;            // depth of void 1 (full thickness = through)
depth_2 = 5.6;            // depth of void 2 (full thickness = through)
depth_3 = 3.1;            // depth of void 3 (full thickness = through)
corner_c = 4;             // corner chamfer of the plate

profile = [[4, 0], [76, 0], [80, 4], [80, 41], [76, 45], [4, 45], [0, 41], [0, 4]];  // primary outline, 8 points, counter clockwise
void_1 = [[12.65, 16.5], [24.65, 16.5], [24.65, 28.5], [12.65, 28.5]];  // window 1 of the row, 4 points
void_2 = [[33.95, 16.5], [45.95, 16.5], [45.95, 28.5], [33.95, 28.5]];  // window 2 of the row, 4 points
void_3 = [[55.25, 16.5], [67.25, 16.5], [67.25, 28.5], [55.25, 28.5]];  // window 3 of the row, 4 points

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
