$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 1 voids, 90 x 80 x 8 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 90;             // plate length, X
plate_w = 80;             // plate width, Y
plate_t = 8;              // plate thickness, Z
edge_margin = 8;          // wall from the plate edge to any window
win1_l = 63.7;            // window length
win1_w = 56.5;            // window width
depth_1 = 5.3;            // depth of void 1 (full thickness = through)
corner_c = 2;             // corner chamfer of the plate

profile = [[2, 0], [88, 0], [90, 2], [90, 78], [88, 80], [2, 80], [0, 78], [0, 2]];  // primary outline, 8 points, counter clockwise
void_1 = [[13.15, 11.75], [76.85, 11.75], [76.85, 68.25], [13.15, 68.25]];  // large central window, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
}
