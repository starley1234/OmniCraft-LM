$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 1 voids, 70 x 60 x 6 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 70;             // plate length, X
plate_w = 60;             // plate width, Y
plate_t = 6;              // plate thickness, Z
edge_margin = 8;          // wall from the plate edge to any window
win1_l = 42.8;            // window length
win1_w = 37.8;            // window width
depth_1 = 6;              // depth of void 1 (full thickness = through)
corner_c = 2.5;           // corner chamfer of the plate

profile = [[2.5, 0], [67.5, 0], [70, 2.5], [70, 57.5], [67.5, 60], [2.5, 60], [0, 57.5], [0, 2.5]];  // primary outline, 8 points, counter clockwise
void_1 = [[13.6, 11.1], [56.4, 11.1], [56.4, 48.9], [13.6, 48.9]];  // large central window, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
