$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 1 voids, 120 x 70 x 5 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 120;            // plate length, X
plate_w = 70;             // plate width, Y
plate_t = 5;              // plate thickness, Z
edge_margin = 8;          // wall from the plate edge to any window
win1_l = 91.2;            // window length
win1_w = 48;              // window width
depth_1 = 5;              // depth of void 1 (full thickness = through)
corner_c = 3;             // corner chamfer of the plate

profile = [[3, 0], [117, 0], [120, 3], [120, 67], [117, 70], [3, 70], [0, 67], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[14.4, 11], [105.6, 11], [105.6, 59], [14.4, 59]];  // large central window, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
}
