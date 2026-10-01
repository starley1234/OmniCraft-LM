$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 4 voids, 120 x 80 x 8 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 120;            // plate length, X
plate_w = 80;             // plate width, Y
plate_t = 8;              // plate thickness, Z
edge_margin = 12;         // wall from the plate edge to any window
win_l = 12;               // pocket length
win_w = 14;               // pocket width
pitch_x = 48;             // grid pitch along X
pitch_y = 28;             // grid pitch along Y
depth_1 = 8;              // depth of void 1 (full thickness = through)
depth_2 = 8;              // depth of void 2 (full thickness = through)
depth_3 = 8;              // depth of void 3 (full thickness = through)
depth_4 = 8;              // depth of void 4 (full thickness = through)
corner_c = 2;             // corner chamfer of the plate

profile = [[2, 0], [118, 0], [120, 2], [120, 78], [118, 80], [2, 80], [0, 78], [0, 2]];  // primary outline, 8 points, counter clockwise
void_1 = [[30, 19], [42, 19], [42, 33], [30, 33]];  // pocket at grid node 0,0, 4 points
void_2 = [[30, 47], [42, 47], [42, 61], [30, 61]];  // pocket at grid node 0,1, 4 points
void_3 = [[78, 19], [90, 19], [90, 33], [78, 33]];  // pocket at grid node 1,0, 4 points
void_4 = [[78, 47], [90, 47], [90, 61], [78, 61]];  // pocket at grid node 1,1, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_2);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_3);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_4);
}
