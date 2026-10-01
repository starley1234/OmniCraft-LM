$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 3 voids, 120 x 60 x 5 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 120;            // plate length, X
plate_w = 60;             // plate width, Y
plate_t = 5;              // plate thickness, Z
edge_margin = 10;         // wall from the plate edge to any window
windows = 3;              // number of windows in the row
win_l = 22;               // window length
win_w = 10;               // window width
win_pitch = 33.3;         // window pitch along X
depth_1 = 5;              // depth of void 1 (full thickness = through)
depth_2 = 5;              // depth of void 2 (full thickness = through)
depth_3 = 5;              // depth of void 3 (full thickness = through)
corner_c = 5;             // corner chamfer of the plate

profile = [[5, 0], [115, 0], [120, 5], [120, 55], [115, 60], [5, 60], [0, 55], [0, 5]];  // primary outline, 8 points, counter clockwise
void_1 = [[15.65, 25], [37.65, 25], [37.65, 35], [15.65, 35]];  // window 1 of the row, 4 points
void_2 = [[48.95, 25], [70.95, 25], [70.95, 35], [48.95, 35]];  // window 2 of the row, 4 points
void_3 = [[82.25, 25], [104.25, 25], [104.25, 35], [82.25, 35]];  // window 3 of the row, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_2);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_3);
}
