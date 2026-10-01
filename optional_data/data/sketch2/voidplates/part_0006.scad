$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 1 voids, 110 x 70 x 6 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 110;            // plate length, X
plate_w = 70;             // plate width, Y
plate_t = 6;              // plate thickness, Z
edge_margin = 8;          // wall from the plate edge to any window
win1_l = 79.5;            // window length
win1_w = 42.1;            // window width
depth_1 = 6;              // depth of void 1 (full thickness = through)
corner_c = 5;             // corner chamfer of the plate

profile = [[5, 0], [105, 0], [110, 5], [110, 65], [105, 70], [5, 70], [0, 65], [0, 5]];  // primary outline, 8 points, counter clockwise
void_1 = [[15.25, 13.95], [94.75, 13.95], [94.75, 56.05], [15.25, 56.05]];  // large central window, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
