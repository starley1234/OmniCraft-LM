$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 1 voids, 110 x 50 x 5 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 110;            // plate length, X
plate_w = 50;             // plate width, Y
plate_t = 5;              // plate thickness, Z
edge_margin = 8;          // wall from the plate edge to any window
win1_l = 85.8;            // window length
win1_w = 22.4;            // window width
depth_1 = 5;              // depth of void 1 (full thickness = through)
corner_c = 3;             // corner chamfer of the plate

profile = [[3, 0], [107, 0], [110, 3], [110, 47], [107, 50], [3, 50], [0, 47], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[12.1, 13.8], [97.9, 13.8], [97.9, 36.2], [12.1, 36.2]];  // large central window, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
