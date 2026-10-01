$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 1 voids, 120 x 50 x 8 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 120;            // plate length, X
plate_w = 50;             // plate width, Y
plate_t = 8;              // plate thickness, Z
edge_margin = 10;         // wall from the plate edge to any window
win1_l = 93.2;            // window length
win1_w = 18.3;            // window width
depth_1 = 2;              // depth of void 1 (full thickness = through)
corner_c = 3;             // corner chamfer of the plate

profile = [[3, 0], [117, 0], [120, 3], [120, 47], [117, 50], [3, 50], [0, 47], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[13.4, 15.85], [106.6, 15.85], [106.6, 34.15], [13.4, 34.15]];  // large central window, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
}
