$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 1 voids, 120 x 45 x 6 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 120;            // plate length, X
plate_w = 45;             // plate width, Y
plate_t = 6;              // plate thickness, Z
edge_margin = 8;          // wall from the plate edge to any window
win1_l = 88.4;            // window length
win1_w = 22.9;            // window width
depth_1 = 1.9;            // depth of void 1 (full thickness = through)
corner_c = 2;             // corner chamfer of the plate

profile = [[2, 0], [118, 0], [120, 2], [120, 43], [118, 45], [2, 45], [0, 43], [0, 2]];  // primary outline, 8 points, counter clockwise
void_1 = [[15.8, 11.05], [104.2, 11.05], [104.2, 33.95], [15.8, 33.95]];  // large central window, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
}
