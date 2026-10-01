$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 1 voids, 100 x 80 x 5 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 100;            // plate length, X
plate_w = 80;             // plate width, Y
plate_t = 5;              // plate thickness, Z
edge_margin = 12;         // wall from the plate edge to any window
win1_l = 66.1;            // window length
win1_w = 47.2;            // window width
depth_1 = 5;              // depth of void 1 (full thickness = through)
corner_c = 5;             // corner chamfer of the plate

profile = [[5, 0], [95, 0], [100, 5], [100, 75], [95, 80], [5, 80], [0, 75], [0, 5]];  // primary outline, 8 points, counter clockwise
void_1 = [[16.95, 16.4], [83.05, 16.4], [83.05, 63.6], [16.95, 63.6]];  // large central window, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
