$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 1 voids, 70 x 45 x 10 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 70;             // plate length, X
plate_w = 45;             // plate width, Y
plate_t = 10;             // plate thickness, Z
edge_margin = 10;         // wall from the plate edge to any window
win1_l = 38.1;            // window length
win1_w = 14.7;            // window width
depth_1 = 3.5;            // depth of void 1 (full thickness = through)
corner_c = 2.5;           // corner chamfer of the plate

profile = [[2.5, 0], [67.5, 0], [70, 2.5], [70, 42.5], [67.5, 45], [2.5, 45], [0, 42.5], [0, 2.5]];  // primary outline, 8 points, counter clockwise
void_1 = [[15.95, 15.15], [54.05, 15.15], [54.05, 29.85], [15.95, 29.85]];  // large central window, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
}
