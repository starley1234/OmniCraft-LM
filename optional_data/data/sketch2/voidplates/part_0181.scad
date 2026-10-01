$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 4 voids, 120 x 80 x 8 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 120;            // plate length, X
plate_w = 80;             // plate width, Y
plate_t = 8;              // plate thickness, Z
edge_margin = 8;          // wall from the plate edge to any window
win_l = 18;               // pocket length
win_w = 10;               // pocket width
pitch_x = 52;             // grid pitch along X
pitch_y = 32;             // grid pitch along Y
depth_1 = 8;              // depth of void 1 (full thickness = through)
depth_2 = 8;              // depth of void 2 (full thickness = through)
depth_3 = 8;              // depth of void 3 (full thickness = through)
depth_4 = 8;              // depth of void 4 (full thickness = through)
corner_c = 2.5;           // corner chamfer of the plate

profile = [[2.5, 0], [117.5, 0], [120, 2.5], [120, 77.5], [117.5, 80], [2.5, 80], [0, 77.5], [0, 2.5]];  // primary outline, 8 points, counter clockwise
void_1 = [[25, 19], [43, 19], [43, 29], [25, 29]];  // pocket at grid node 0,0, 4 points
void_2 = [[25, 51], [43, 51], [43, 61], [25, 61]];  // pocket at grid node 0,1, 4 points
void_3 = [[77, 19], [95, 19], [95, 29], [77, 29]];  // pocket at grid node 1,0, 4 points
void_4 = [[77, 51], [95, 51], [95, 61], [77, 61]];  // pocket at grid node 1,1, 4 points

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
