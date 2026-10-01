$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 1 voids, 110 x 60 x 8 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 110;            // plate length, X
plate_w = 60;             // plate width, Y
plate_t = 8;              // plate thickness, Z
edge_margin = 8;          // wall from the plate edge to any window
win1_l = 81.7;            // window length
win1_w = 36;              // window width
depth_1 = 8;              // depth of void 1 (full thickness = through)
corner_c = 4;             // corner chamfer of the plate

profile = [[4, 0], [106, 0], [110, 4], [110, 56], [106, 60], [4, 60], [0, 56], [0, 4]];  // primary outline, 8 points, counter clockwise
void_1 = [[14.15, 12], [95.85, 12], [95.85, 48], [14.15, 48]];  // large central window, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
