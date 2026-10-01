$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 1 voids, 110 x 60 x 8 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 110;            // plate length, X
plate_w = 60;             // plate width, Y
plate_t = 8;              // plate thickness, Z
edge_margin = 12;         // wall from the plate edge to any window
win1_l = 78.2;            // window length
win1_w = 24.5;            // window width
depth_1 = 8;              // depth of void 1 (full thickness = through)
corner_c = 3;             // corner chamfer of the plate

profile = [[3, 0], [107, 0], [110, 3], [110, 57], [107, 60], [3, 60], [0, 57], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[15.9, 17.75], [94.1, 17.75], [94.1, 42.25], [15.9, 42.25]];  // large central window, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
