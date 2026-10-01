$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 1 voids, 90 x 50 x 5 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 90;             // plate length, X
plate_w = 50;             // plate width, Y
plate_t = 5;              // plate thickness, Z
edge_margin = 8;          // wall from the plate edge to any window
win1_l = 61.4;            // window length
win1_w = 27.2;            // window width
depth_1 = 5;              // depth of void 1 (full thickness = through)
corner_c = 2;             // corner chamfer of the plate

profile = [[2, 0], [88, 0], [90, 2], [90, 48], [88, 50], [2, 50], [0, 48], [0, 2]];  // primary outline, 8 points, counter clockwise
void_1 = [[14.3, 11.4], [75.7, 11.4], [75.7, 38.6], [14.3, 38.6]];  // large central window, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
