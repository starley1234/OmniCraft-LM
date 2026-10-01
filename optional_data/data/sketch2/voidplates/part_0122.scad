$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 1 voids, 90 x 45 x 5 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 90;             // plate length, X
plate_w = 45;             // plate width, Y
plate_t = 5;              // plate thickness, Z
edge_margin = 12;         // wall from the plate edge to any window
win1_l = 54.4;            // window length
win1_w = 13.7;            // window width
depth_1 = 5;              // depth of void 1 (full thickness = through)
corner_c = 5;             // corner chamfer of the plate

profile = [[5, 0], [85, 0], [90, 5], [90, 40], [85, 45], [5, 45], [0, 40], [0, 5]];  // primary outline, 8 points, counter clockwise
void_1 = [[17.8, 15.65], [72.2, 15.65], [72.2, 29.35], [17.8, 29.35]];  // large central window, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
