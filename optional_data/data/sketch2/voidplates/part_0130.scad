$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 1 voids, 80 x 50 x 6 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 80;             // plate length, X
plate_w = 50;             // plate width, Y
plate_t = 6;              // plate thickness, Z
edge_margin = 12;         // wall from the plate edge to any window
win1_l = 47.9;            // window length
win1_w = 16.1;            // window width
depth_1 = 6;              // depth of void 1 (full thickness = through)
corner_c = 2;             // corner chamfer of the plate

profile = [[2, 0], [78, 0], [80, 2], [80, 48], [78, 50], [2, 50], [0, 48], [0, 2]];  // primary outline, 8 points, counter clockwise
void_1 = [[16.05, 16.95], [63.95, 16.95], [63.95, 33.05], [16.05, 33.05]];  // large central window, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
