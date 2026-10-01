$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 1 voids, 70 x 45 x 5 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 70;             // plate length, X
plate_w = 45;             // plate width, Y
plate_t = 5;              // plate thickness, Z
edge_margin = 12;         // wall from the plate edge to any window
win1_l = 35.6;            // window length
win1_w = 10.4;            // window width
depth_1 = 5;              // depth of void 1 (full thickness = through)
corner_c = 3;             // corner chamfer of the plate

profile = [[3, 0], [67, 0], [70, 3], [70, 42], [67, 45], [3, 45], [0, 42], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[17.2, 17.3], [52.8, 17.3], [52.8, 27.7], [17.2, 27.7]];  // large central window, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
