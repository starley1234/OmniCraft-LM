$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 2 voids, 90 x 60 x 8 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 90;             // plate length, X
plate_w = 60;             // plate width, Y
plate_t = 8;              // plate thickness, Z
edge_margin = 12;         // wall from the plate edge to any window
windows = 2;              // number of windows in the row
win_l = 15;               // window length
win_w = 14;               // window width
win_pitch = 33;           // window pitch along X
depth_1 = 3.8;            // depth of void 1 (full thickness = through)
depth_2 = 5.2;            // depth of void 2 (full thickness = through)
corner_c = 2.5;           // corner chamfer of the plate

profile = [[2.5, 0], [87.5, 0], [90, 2.5], [90, 57.5], [87.5, 60], [2.5, 60], [0, 57.5], [0, 2.5]];  // primary outline, 8 points, counter clockwise
void_1 = [[21, 23], [36, 23], [36, 37], [21, 37]];  // window 1 of the row, 4 points
void_2 = [[54, 23], [69, 23], [69, 37], [54, 37]];  // window 2 of the row, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
  translate([0, 0, plate_t - depth_2])
    linear_extrude(height = depth_2 + 1) polygon(points = void_2);
}
