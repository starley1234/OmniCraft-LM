$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 1 voids, 90 x 80 x 6 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 90;             // plate length, X
plate_w = 80;             // plate width, Y
plate_t = 6;              // plate thickness, Z
edge_margin = 12;         // wall from the plate edge to any window
win1_l = 57.8;            // window length
win1_w = 48.7;            // window width
depth_1 = 4.2;            // depth of void 1 (full thickness = through)
corner_c = 4;             // corner chamfer of the plate

profile = [[4, 0], [86, 0], [90, 4], [90, 76], [86, 80], [4, 80], [0, 76], [0, 4]];  // primary outline, 8 points, counter clockwise
void_1 = [[16.1, 15.65], [73.9, 15.65], [73.9, 64.35], [16.1, 64.35]];  // large central window, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
}
