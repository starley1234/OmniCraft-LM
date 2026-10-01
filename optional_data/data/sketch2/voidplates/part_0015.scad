$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 1 voids, 100 x 80 x 10 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 100;            // plate length, X
plate_w = 80;             // plate width, Y
plate_t = 10;             // plate thickness, Z
edge_margin = 10;         // wall from the plate edge to any window
win1_l = 70.1;            // window length
win1_w = 52.6;            // window width
depth_1 = 10;             // depth of void 1 (full thickness = through)
corner_c = 2.5;           // corner chamfer of the plate

profile = [[2.5, 0], [97.5, 0], [100, 2.5], [100, 77.5], [97.5, 80], [2.5, 80], [0, 77.5], [0, 2.5]];  // primary outline, 8 points, counter clockwise
void_1 = [[14.95, 13.7], [85.05, 13.7], [85.05, 66.3], [14.95, 66.3]];  // large central window, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
