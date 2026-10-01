$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 1 voids, 80 x 80 x 10 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 80;             // plate length, X
plate_w = 80;             // plate width, Y
plate_t = 10;             // plate thickness, Z
edge_margin = 8;          // wall from the plate edge to any window
win1_l = 50;              // window length
win1_w = 54;              // window width
depth_1 = 10;             // depth of void 1 (full thickness = through)
corner_c = 2;             // corner chamfer of the plate

profile = [[2, 0], [78, 0], [80, 2], [80, 78], [78, 80], [2, 80], [0, 78], [0, 2]];  // primary outline, 8 points, counter clockwise
void_1 = [[15, 13], [65, 13], [65, 67], [15, 67]];  // large central window, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
