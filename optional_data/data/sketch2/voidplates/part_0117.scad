$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 1 voids, 110 x 50 x 10 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 110;            // plate length, X
plate_w = 50;             // plate width, Y
plate_t = 10;             // plate thickness, Z
edge_margin = 12;         // wall from the plate edge to any window
win1_l = 71.9;            // window length
win1_w = 14.6;            // window width
depth_1 = 10;             // depth of void 1 (full thickness = through)
corner_c = 4;             // corner chamfer of the plate

profile = [[4, 0], [106, 0], [110, 4], [110, 46], [106, 50], [4, 50], [0, 46], [0, 4]];  // primary outline, 8 points, counter clockwise
void_1 = [[19.05, 17.7], [90.95, 17.7], [90.95, 32.3], [19.05, 32.3]];  // large central window, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
