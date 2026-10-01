$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 2 voids, 90 x 50 x 5 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 90;             // plate length, X
plate_w = 50;             // plate width, Y
plate_t = 5;              // plate thickness, Z
edge_margin = 12;         // wall from the plate edge to any window
windows = 2;              // number of windows in the row
win_l = 18;               // window length
win_w = 10;               // window width
win_pitch = 33;           // window pitch along X
depth_1 = 5;              // depth of void 1 (full thickness = through)
depth_2 = 5;              // depth of void 2 (full thickness = through)
corner_c = 3;             // corner chamfer of the plate

profile = [[3, 0], [87, 0], [90, 3], [90, 47], [87, 50], [3, 50], [0, 47], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[19.5, 20], [37.5, 20], [37.5, 30], [19.5, 30]];  // window 1 of the row, 4 points
void_2 = [[52.5, 20], [70.5, 20], [70.5, 30], [52.5, 30]];  // window 2 of the row, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_2);
}
