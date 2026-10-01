$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 4 voids, 100 x 60 x 5 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 100;            // plate length, X
plate_w = 60;             // plate width, Y
plate_t = 5;              // plate thickness, Z
edge_margin = 12;         // wall from the plate edge to any window
win_l = 12;               // pocket length
win_w = 14;               // pocket width
pitch_x = 38;             // grid pitch along X
pitch_y = 18;             // grid pitch along Y
depth_1 = 1.6;            // depth of void 1 (full thickness = through)
depth_2 = 1.9;            // depth of void 2 (full thickness = through)
depth_3 = 5;              // depth of void 3 (full thickness = through)
depth_4 = 3;              // depth of void 4 (full thickness = through)
corner_c = 3;             // corner chamfer of the plate

profile = [[3, 0], [97, 0], [100, 3], [100, 57], [97, 60], [3, 60], [0, 57], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[25, 14], [37, 14], [37, 28], [25, 28]];  // pocket at grid node 0,0, 4 points
void_2 = [[25, 32], [37, 32], [37, 46], [25, 46]];  // pocket at grid node 0,1, 4 points
void_3 = [[63, 14], [75, 14], [75, 28], [63, 28]];  // pocket at grid node 1,0, 4 points
void_4 = [[63, 32], [75, 32], [75, 46], [63, 46]];  // pocket at grid node 1,1, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
  translate([0, 0, plate_t - depth_2])
    linear_extrude(height = depth_2 + 1) polygon(points = void_2);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_3);
  translate([0, 0, plate_t - depth_4])
    linear_extrude(height = depth_4 + 1) polygon(points = void_4);
}
