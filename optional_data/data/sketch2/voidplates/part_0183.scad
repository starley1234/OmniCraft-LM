$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 1 voids, 100 x 45 x 10 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 100;            // plate length, X
plate_w = 45;             // plate width, Y
plate_t = 10;             // plate thickness, Z
edge_margin = 12;         // wall from the plate edge to any window
win1_l = 63.5;            // window length
win1_w = 11.1;            // window width
depth_1 = 10;             // depth of void 1 (full thickness = through)
corner_c = 5;             // corner chamfer of the plate

profile = [[5, 0], [95, 0], [100, 5], [100, 40], [95, 45], [5, 45], [0, 40], [0, 5]];  // primary outline, 8 points, counter clockwise
void_1 = [[18.25, 16.95], [81.75, 16.95], [81.75, 28.05], [18.25, 28.05]];  // large central window, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
