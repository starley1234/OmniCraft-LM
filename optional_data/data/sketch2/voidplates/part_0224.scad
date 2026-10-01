$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 4 voids, 90 x 80 x 8 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 90;             // plate length, X
plate_w = 80;             // plate width, Y
plate_t = 8;              // plate thickness, Z
edge_margin = 8;          // wall from the plate edge to any window
win_l = 12;               // pocket length
win_w = 10;               // pocket width
pitch_x = 37;             // grid pitch along X
pitch_y = 32;             // grid pitch along Y
depth_1 = 8;              // depth of void 1 (full thickness = through)
depth_2 = 8;              // depth of void 2 (full thickness = through)
depth_3 = 8;              // depth of void 3 (full thickness = through)
depth_4 = 8;              // depth of void 4 (full thickness = through)
corner_c = 3;             // corner chamfer of the plate

profile = [[3, 0], [87, 0], [90, 3], [90, 77], [87, 80], [3, 80], [0, 77], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[20.5, 19], [32.5, 19], [32.5, 29], [20.5, 29]];  // pocket at grid node 0,0, 4 points
void_2 = [[20.5, 51], [32.5, 51], [32.5, 61], [20.5, 61]];  // pocket at grid node 0,1, 4 points
void_3 = [[57.5, 19], [69.5, 19], [69.5, 29], [57.5, 29]];  // pocket at grid node 1,0, 4 points
void_4 = [[57.5, 51], [69.5, 51], [69.5, 61], [57.5, 61]];  // pocket at grid node 1,1, 4 points

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
