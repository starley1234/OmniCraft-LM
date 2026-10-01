$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 1 voids, 110 x 60 x 10 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 110;            // plate length, X
plate_w = 60;             // plate width, Y
plate_t = 10;             // plate thickness, Z
edge_margin = 8;          // wall from the plate edge to any window
win1_l = 87.3;            // window length
win1_w = 34.5;            // window width
depth_1 = 10;             // depth of void 1 (full thickness = through)
corner_c = 5;             // corner chamfer of the plate

profile = [[5, 0], [105, 0], [110, 5], [110, 55], [105, 60], [5, 60], [0, 55], [0, 5]];  // primary outline, 8 points, counter clockwise
void_1 = [[11.35, 12.75], [98.65, 12.75], [98.65, 47.25], [11.35, 47.25]];  // large central window, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
