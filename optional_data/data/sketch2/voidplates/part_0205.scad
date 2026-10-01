$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 4 voids, 90 x 70 x 10 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 90;             // plate length, X
plate_w = 70;             // plate width, Y
plate_t = 10;             // plate thickness, Z
edge_margin = 8;          // wall from the plate edge to any window
win_l = 12;               // pocket length
win_w = 14;               // pocket width
pitch_x = 37;             // grid pitch along X
pitch_y = 27;             // grid pitch along Y
depth_1 = 10;             // depth of void 1 (full thickness = through)
depth_2 = 10;             // depth of void 2 (full thickness = through)
depth_3 = 10;             // depth of void 3 (full thickness = through)
depth_4 = 10;             // depth of void 4 (full thickness = through)
corner_c = 2;             // corner chamfer of the plate

profile = [[2, 0], [88, 0], [90, 2], [90, 68], [88, 70], [2, 70], [0, 68], [0, 2]];  // primary outline, 8 points, counter clockwise
void_1 = [[20.5, 14.5], [32.5, 14.5], [32.5, 28.5], [20.5, 28.5]];  // pocket at grid node 0,0, 4 points
void_2 = [[20.5, 41.5], [32.5, 41.5], [32.5, 55.5], [20.5, 55.5]];  // pocket at grid node 0,1, 4 points
void_3 = [[57.5, 14.5], [69.5, 14.5], [69.5, 28.5], [57.5, 28.5]];  // pocket at grid node 1,0, 4 points
void_4 = [[57.5, 41.5], [69.5, 41.5], [69.5, 55.5], [57.5, 55.5]];  // pocket at grid node 1,1, 4 points

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
