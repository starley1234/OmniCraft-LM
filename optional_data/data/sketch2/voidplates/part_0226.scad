$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 1 voids, 90 x 50 x 10 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 90;             // plate length, X
plate_w = 50;             // plate width, Y
plate_t = 10;             // plate thickness, Z
edge_margin = 12;         // wall from the plate edge to any window
win1_l = 54.1;            // window length
win1_w = 18.1;            // window width
depth_1 = 5.9;            // depth of void 1 (full thickness = through)
corner_c = 2.5;           // corner chamfer of the plate

profile = [[2.5, 0], [87.5, 0], [90, 2.5], [90, 47.5], [87.5, 50], [2.5, 50], [0, 47.5], [0, 2.5]];  // primary outline, 8 points, counter clockwise
void_1 = [[17.95, 15.95], [72.05, 15.95], [72.05, 34.05], [17.95, 34.05]];  // large central window, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
}
