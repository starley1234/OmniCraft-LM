$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 1 voids, 120 x 80 x 6 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 120;            // plate length, X
plate_w = 80;             // plate width, Y
plate_t = 6;              // plate thickness, Z
edge_margin = 12;         // wall from the plate edge to any window
win1_l = 83.6;            // window length
win1_w = 48.1;            // window width
depth_1 = 2.9;            // depth of void 1 (full thickness = through)
corner_c = 3;             // corner chamfer of the plate

profile = [[3, 0], [117, 0], [120, 3], [120, 77], [117, 80], [3, 80], [0, 77], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[18.2, 15.95], [101.8, 15.95], [101.8, 64.05], [18.2, 64.05]];  // large central window, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
}
