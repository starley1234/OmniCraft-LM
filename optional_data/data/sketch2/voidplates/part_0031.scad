$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 1 voids, 80 x 45 x 8 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 80;             // plate length, X
plate_w = 45;             // plate width, Y
plate_t = 8;              // plate thickness, Z
edge_margin = 12;         // wall from the plate edge to any window
win1_l = 46.6;            // window length
win1_w = 10.2;            // window width
depth_1 = 8;              // depth of void 1 (full thickness = through)
corner_c = 2;             // corner chamfer of the plate

profile = [[2, 0], [78, 0], [80, 2], [80, 43], [78, 45], [2, 45], [0, 43], [0, 2]];  // primary outline, 8 points, counter clockwise
void_1 = [[16.7, 17.4], [63.3, 17.4], [63.3, 27.6], [16.7, 27.6]];  // large central window, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
