$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 1 voids, 100 x 60 x 8 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 100;            // plate length, X
plate_w = 60;             // plate width, Y
plate_t = 8;              // plate thickness, Z
edge_margin = 8;          // wall from the plate edge to any window
win1_l = 74.1;            // window length
win1_w = 37.8;            // window width
depth_1 = 2.3;            // depth of void 1 (full thickness = through)
corner_c = 4;             // corner chamfer of the plate

profile = [[4, 0], [96, 0], [100, 4], [100, 56], [96, 60], [4, 60], [0, 56], [0, 4]];  // primary outline, 8 points, counter clockwise
void_1 = [[12.95, 11.1], [87.05, 11.1], [87.05, 48.9], [12.95, 48.9]];  // large central window, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
}
