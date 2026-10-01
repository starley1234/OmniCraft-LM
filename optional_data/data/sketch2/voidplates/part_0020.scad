$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 3 voids, 120 x 50 x 6 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 120;            // plate length, X
plate_w = 50;             // plate width, Y
plate_t = 6;              // plate thickness, Z
edge_margin = 8;          // wall from the plate edge to any window
windows = 3;              // number of windows in the row
win_l = 15;               // window length
win_w = 12;               // window width
win_pitch = 34.7;         // window pitch along X
depth_1 = 6;              // depth of void 1 (full thickness = through)
depth_2 = 6;              // depth of void 2 (full thickness = through)
depth_3 = 6;              // depth of void 3 (full thickness = through)
corner_c = 2.5;           // corner chamfer of the plate

profile = [[2.5, 0], [117.5, 0], [120, 2.5], [120, 47.5], [117.5, 50], [2.5, 50], [0, 47.5], [0, 2.5]];  // primary outline, 8 points, counter clockwise
void_1 = [[17.85, 19], [32.85, 19], [32.85, 31], [17.85, 31]];  // window 1 of the row, 4 points
void_2 = [[52.55, 19], [67.55, 19], [67.55, 31], [52.55, 31]];  // window 2 of the row, 4 points
void_3 = [[87.25, 19], [102.25, 19], [102.25, 31], [87.25, 31]];  // window 3 of the row, 4 points

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
