$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 1 voids, 90 x 70 x 6 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 90;             // plate length, X
plate_w = 70;             // plate width, Y
plate_t = 6;              // plate thickness, Z
edge_margin = 8;          // wall from the plate edge to any window
win1_l = 62.1;            // window length
win1_w = 46.6;            // window width
depth_1 = 6;              // depth of void 1 (full thickness = through)
corner_c = 4;             // corner chamfer of the plate

profile = [[4, 0], [86, 0], [90, 4], [90, 66], [86, 70], [4, 70], [0, 66], [0, 4]];  // primary outline, 8 points, counter clockwise
void_1 = [[13.95, 11.7], [76.05, 11.7], [76.05, 58.3], [13.95, 58.3]];  // large central window, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
