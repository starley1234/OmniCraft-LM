$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 1 voids, 110 x 45 x 10 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 110;            // plate length, X
plate_w = 45;             // plate width, Y
plate_t = 10;             // plate thickness, Z
edge_margin = 12;         // wall from the plate edge to any window
win1_l = 71.1;            // window length
win1_w = 10.1;            // window width
depth_1 = 10;             // depth of void 1 (full thickness = through)
corner_c = 2.5;           // corner chamfer of the plate

profile = [[2.5, 0], [107.5, 0], [110, 2.5], [110, 42.5], [107.5, 45], [2.5, 45], [0, 42.5], [0, 2.5]];  // primary outline, 8 points, counter clockwise
void_1 = [[19.45, 17.45], [90.55, 17.45], [90.55, 27.55], [19.45, 27.55]];  // large central window, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
