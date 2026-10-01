$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 1 voids, 80 x 60 x 10 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 80;             // plate length, X
plate_w = 60;             // plate width, Y
plate_t = 10;             // plate thickness, Z
edge_margin = 12;         // wall from the plate edge to any window
win1_l = 43.9;            // window length
win1_w = 24.8;            // window width
depth_1 = 8.5;            // depth of void 1 (full thickness = through)
corner_c = 2;             // corner chamfer of the plate

profile = [[2, 0], [78, 0], [80, 2], [80, 58], [78, 60], [2, 60], [0, 58], [0, 2]];  // primary outline, 8 points, counter clockwise
void_1 = [[18.05, 17.6], [61.95, 17.6], [61.95, 42.4], [18.05, 42.4]];  // large central window, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
}
