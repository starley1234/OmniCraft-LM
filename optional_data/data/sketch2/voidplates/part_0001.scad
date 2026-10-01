$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 1 voids, 110 x 60 x 6 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 110;            // plate length, X
plate_w = 60;             // plate width, Y
plate_t = 6;              // plate thickness, Z
edge_margin = 10;         // wall from the plate edge to any window
win1_l = 81.1;            // window length
win1_w = 32.1;            // window width
depth_1 = 4.4;            // depth of void 1 (full thickness = through)
corner_c = 2;             // corner chamfer of the plate

profile = [[2, 0], [108, 0], [110, 2], [110, 58], [108, 60], [2, 60], [0, 58], [0, 2]];  // primary outline, 8 points, counter clockwise
void_1 = [[14.45, 13.95], [95.55, 13.95], [95.55, 46.05], [14.45, 46.05]];  // large central window, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
}
