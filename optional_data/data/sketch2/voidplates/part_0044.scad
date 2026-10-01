$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 1 voids, 80 x 50 x 6 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 80;             // plate length, X
plate_w = 50;             // plate width, Y
plate_t = 6;              // plate thickness, Z
edge_margin = 10;         // wall from the plate edge to any window
win1_l = 44.2;            // window length
win1_w = 19.5;            // window width
depth_1 = 2.7;            // depth of void 1 (full thickness = through)
corner_c = 2.5;           // corner chamfer of the plate

profile = [[2.5, 0], [77.5, 0], [80, 2.5], [80, 47.5], [77.5, 50], [2.5, 50], [0, 47.5], [0, 2.5]];  // primary outline, 8 points, counter clockwise
void_1 = [[17.9, 15.25], [62.1, 15.25], [62.1, 34.75], [17.9, 34.75]];  // large central window, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
}
