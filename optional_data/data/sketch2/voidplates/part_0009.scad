$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 1 voids, 100 x 45 x 5 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 100;            // plate length, X
plate_w = 45;             // plate width, Y
plate_t = 5;              // plate thickness, Z
edge_margin = 12;         // wall from the plate edge to any window
win1_l = 67.8;            // window length
win1_w = 11.2;            // window width
depth_1 = 2.4;            // depth of void 1 (full thickness = through)
corner_c = 2.5;           // corner chamfer of the plate

profile = [[2.5, 0], [97.5, 0], [100, 2.5], [100, 42.5], [97.5, 45], [2.5, 45], [0, 42.5], [0, 2.5]];  // primary outline, 8 points, counter clockwise
void_1 = [[16.1, 16.9], [83.9, 16.9], [83.9, 28.1], [16.1, 28.1]];  // large central window, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
}
