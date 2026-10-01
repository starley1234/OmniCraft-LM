$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 2 voids, 90 x 60 x 10 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 90;             // plate length, X
plate_w = 60;             // plate width, Y
plate_t = 10;             // plate thickness, Z
edge_margin = 12;         // wall from the plate edge to any window
windows = 2;              // number of windows in the row
win_l = 15;               // window length
win_w = 12;               // window width
win_pitch = 33;           // window pitch along X
depth_1 = 10;             // depth of void 1 (full thickness = through)
depth_2 = 10;             // depth of void 2 (full thickness = through)
corner_c = 5;             // corner chamfer of the plate

profile = [[5, 0], [85, 0], [90, 5], [90, 55], [85, 60], [5, 60], [0, 55], [0, 5]];  // primary outline, 8 points, counter clockwise
void_1 = [[21, 24], [36, 24], [36, 36], [21, 36]];  // window 1 of the row, 4 points
void_2 = [[54, 24], [69, 24], [69, 36], [54, 36]];  // window 2 of the row, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_2);
}
