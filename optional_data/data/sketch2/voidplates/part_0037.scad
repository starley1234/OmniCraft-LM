$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 2 voids, 80 x 45 x 6 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 80;             // plate length, X
plate_w = 45;             // plate width, Y
plate_t = 6;              // plate thickness, Z
edge_margin = 8;          // wall from the plate edge to any window
windows = 2;              // number of windows in the row
win_l = 15;               // window length
win_w = 10;               // window width
win_pitch = 32;           // window pitch along X
depth_1 = 6;              // depth of void 1 (full thickness = through)
depth_2 = 6;              // depth of void 2 (full thickness = through)
corner_c = 3;             // corner chamfer of the plate

profile = [[3, 0], [77, 0], [80, 3], [80, 42], [77, 45], [3, 45], [0, 42], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[16.5, 17.5], [31.5, 17.5], [31.5, 27.5], [16.5, 27.5]];  // window 1 of the row, 4 points
void_2 = [[48.5, 17.5], [63.5, 17.5], [63.5, 27.5], [48.5, 27.5]];  // window 2 of the row, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_2);
}
