$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 3 voids, 70 x 45 x 8 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 70;             // plate length, X
plate_w = 45;             // plate width, Y
plate_t = 8;              // plate thickness, Z
edge_margin = 10;         // wall from the plate edge to any window
windows = 3;              // number of windows in the row
win_l = 12;               // window length
win_w = 12;               // window width
win_pitch = 16.7;         // window pitch along X
depth_1 = 8;              // depth of void 1 (full thickness = through)
depth_2 = 8;              // depth of void 2 (full thickness = through)
depth_3 = 8;              // depth of void 3 (full thickness = through)
corner_c = 4;             // corner chamfer of the plate

profile = [[4, 0], [66, 0], [70, 4], [70, 41], [66, 45], [4, 45], [0, 41], [0, 4]];  // primary outline, 8 points, counter clockwise
void_1 = [[12.35, 16.5], [24.35, 16.5], [24.35, 28.5], [12.35, 28.5]];  // window 1 of the row, 4 points
void_2 = [[29.05, 16.5], [41.05, 16.5], [41.05, 28.5], [29.05, 28.5]];  // window 2 of the row, 4 points
void_3 = [[45.75, 16.5], [57.75, 16.5], [57.75, 28.5], [45.75, 28.5]];  // window 3 of the row, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_2);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_3);
}
