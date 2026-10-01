$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 3 voids, 100 x 60 x 5 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 100;            // plate length, X
plate_w = 60;             // plate width, Y
plate_t = 5;              // plate thickness, Z
edge_margin = 10;         // wall from the plate edge to any window
windows = 3;              // number of windows in the row
win_l = 18;               // window length
win_w = 14;               // window width
win_pitch = 26.7;         // window pitch along X
depth_1 = 5;              // depth of void 1 (full thickness = through)
depth_2 = 5;              // depth of void 2 (full thickness = through)
depth_3 = 5;              // depth of void 3 (full thickness = through)
corner_c = 2.5;           // corner chamfer of the plate

profile = [[2.5, 0], [97.5, 0], [100, 2.5], [100, 57.5], [97.5, 60], [2.5, 60], [0, 57.5], [0, 2.5]];  // primary outline, 8 points, counter clockwise
void_1 = [[14.35, 23], [32.35, 23], [32.35, 37], [14.35, 37]];  // window 1 of the row, 4 points
void_2 = [[41.05, 23], [59.05, 23], [59.05, 37], [41.05, 37]];  // window 2 of the row, 4 points
void_3 = [[67.75, 23], [85.75, 23], [85.75, 37], [67.75, 37]];  // window 3 of the row, 4 points

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
