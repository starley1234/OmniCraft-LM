$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 1 voids, 90 x 50 x 10 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 90;             // plate length, X
plate_w = 50;             // plate width, Y
plate_t = 10;             // plate thickness, Z
edge_margin = 12;         // wall from the plate edge to any window
win1_l = 59.8;            // window length
win1_w = 17.7;            // window width
depth_1 = 10;             // depth of void 1 (full thickness = through)
corner_c = 3;             // corner chamfer of the plate

profile = [[3, 0], [87, 0], [90, 3], [90, 47], [87, 50], [3, 50], [0, 47], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[15.1, 16.15], [74.9, 16.15], [74.9, 33.85], [15.1, 33.85]];  // large central window, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
