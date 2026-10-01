$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 2 voids, 80 x 45 x 10 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 80;             // plate length, X
plate_w = 45;             // plate width, Y
plate_t = 10;             // plate thickness, Z
edge_margin = 12;         // wall from the plate edge to any window
windows = 2;              // number of windows in the row
win_l = 12;               // window length
win_w = 10;               // window width
win_pitch = 28;           // window pitch along X
depth_1 = 10;             // depth of void 1 (full thickness = through)
depth_2 = 10;             // depth of void 2 (full thickness = through)
corner_c = 3;             // corner chamfer of the plate

profile = [[3, 0], [77, 0], [80, 3], [80, 42], [77, 45], [3, 45], [0, 42], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[20, 17.5], [32, 17.5], [32, 27.5], [20, 27.5]];  // window 1 of the row, 4 points
void_2 = [[48, 17.5], [60, 17.5], [60, 27.5], [48, 27.5]];  // window 2 of the row, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_2);
}
