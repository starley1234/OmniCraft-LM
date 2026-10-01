$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 3 voids, 120 x 45 x 5 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 120;            // plate length, X
plate_w = 45;             // plate width, Y
plate_t = 5;              // plate thickness, Z
edge_margin = 12;         // wall from the plate edge to any window
windows = 3;              // number of windows in the row
win_l = 22;               // window length
win_w = 12;               // window width
win_pitch = 32;           // window pitch along X
depth_1 = 3.3;            // depth of void 1 (full thickness = through)
depth_2 = 2.2;            // depth of void 2 (full thickness = through)
depth_3 = 1.6;            // depth of void 3 (full thickness = through)
corner_c = 3;             // corner chamfer of the plate

profile = [[3, 0], [117, 0], [120, 3], [120, 42], [117, 45], [3, 45], [0, 42], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[17, 16.5], [39, 16.5], [39, 28.5], [17, 28.5]];  // window 1 of the row, 4 points
void_2 = [[49, 16.5], [71, 16.5], [71, 28.5], [49, 28.5]];  // window 2 of the row, 4 points
void_3 = [[81, 16.5], [103, 16.5], [103, 28.5], [81, 28.5]];  // window 3 of the row, 4 points

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
