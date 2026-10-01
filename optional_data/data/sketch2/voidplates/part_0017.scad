$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 1 voids, 100 x 50 x 6 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 100;            // plate length, X
plate_w = 50;             // plate width, Y
plate_t = 6;              // plate thickness, Z
edge_margin = 12;         // wall from the plate edge to any window
win1_l = 62.1;            // window length
win1_w = 16;              // window width
depth_1 = 6;              // depth of void 1 (full thickness = through)
corner_c = 2.5;           // corner chamfer of the plate

profile = [[2.5, 0], [97.5, 0], [100, 2.5], [100, 47.5], [97.5, 50], [2.5, 50], [0, 47.5], [0, 2.5]];  // primary outline, 8 points, counter clockwise
void_1 = [[18.95, 17], [81.05, 17], [81.05, 33], [18.95, 33]];  // large central window, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
