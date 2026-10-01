$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 1 voids, 120 x 50 x 5 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 120;            // plate length, X
plate_w = 50;             // plate width, Y
plate_t = 5;              // plate thickness, Z
edge_margin = 8;          // wall from the plate edge to any window
win1_l = 95.7;            // window length
win1_w = 25.2;            // window width
depth_1 = 2.3;            // depth of void 1 (full thickness = through)
corner_c = 2;             // corner chamfer of the plate

profile = [[2, 0], [118, 0], [120, 2], [120, 48], [118, 50], [2, 50], [0, 48], [0, 2]];  // primary outline, 8 points, counter clockwise
void_1 = [[12.15, 12.4], [107.85, 12.4], [107.85, 37.6], [12.15, 37.6]];  // large central window, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
}
