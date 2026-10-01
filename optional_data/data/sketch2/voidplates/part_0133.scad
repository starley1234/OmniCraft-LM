$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 1 voids, 120 x 80 x 8 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 120;            // plate length, X
plate_w = 80;             // plate width, Y
plate_t = 8;              // plate thickness, Z
edge_margin = 10;         // wall from the plate edge to any window
win1_l = 85.5;            // window length
win1_w = 53.1;            // window width
depth_1 = 8;              // depth of void 1 (full thickness = through)
corner_c = 2.5;           // corner chamfer of the plate

profile = [[2.5, 0], [117.5, 0], [120, 2.5], [120, 77.5], [117.5, 80], [2.5, 80], [0, 77.5], [0, 2.5]];  // primary outline, 8 points, counter clockwise
void_1 = [[17.25, 13.45], [102.75, 13.45], [102.75, 66.55], [17.25, 66.55]];  // large central window, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
