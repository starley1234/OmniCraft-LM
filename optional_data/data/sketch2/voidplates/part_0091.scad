$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 1 voids, 70 x 60 x 5 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 70;             // plate length, X
plate_w = 60;             // plate width, Y
plate_t = 5;              // plate thickness, Z
edge_margin = 12;         // wall from the plate edge to any window
win1_l = 35.5;            // window length
win1_w = 29.8;            // window width
depth_1 = 3.3;            // depth of void 1 (full thickness = through)
corner_c = 5;             // corner chamfer of the plate

profile = [[5, 0], [65, 0], [70, 5], [70, 55], [65, 60], [5, 60], [0, 55], [0, 5]];  // primary outline, 8 points, counter clockwise
void_1 = [[17.25, 15.1], [52.75, 15.1], [52.75, 44.9], [17.25, 44.9]];  // large central window, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
}
