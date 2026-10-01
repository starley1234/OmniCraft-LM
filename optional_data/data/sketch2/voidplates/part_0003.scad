$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 4 voids, 100 x 45 x 8 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 100;            // plate length, X
plate_w = 45;             // plate width, Y
plate_t = 8;              // plate thickness, Z
edge_margin = 8;          // wall from the plate edge to any window
win_l = 15;               // pocket length
win_w = 10;               // pocket width
pitch_x = 42;             // grid pitch along X
pitch_y = 14.5;           // grid pitch along Y
depth_1 = 4.5;            // depth of void 1 (full thickness = through)
depth_2 = 3.3;            // depth of void 2 (full thickness = through)
depth_3 = 8;              // depth of void 3 (full thickness = through)
depth_4 = 4.7;            // depth of void 4 (full thickness = through)
corner_c = 4;             // corner chamfer of the plate

profile = [[4, 0], [96, 0], [100, 4], [100, 41], [96, 45], [4, 45], [0, 41], [0, 4]];  // primary outline, 8 points, counter clockwise
void_1 = [[21.5, 10.25], [36.5, 10.25], [36.5, 20.25], [21.5, 20.25]];  // pocket at grid node 0,0, 4 points
void_2 = [[21.5, 24.75], [36.5, 24.75], [36.5, 34.75], [21.5, 34.75]];  // pocket at grid node 0,1, 4 points
void_3 = [[63.5, 10.25], [78.5, 10.25], [78.5, 20.25], [63.5, 20.25]];  // pocket at grid node 1,0, 4 points
void_4 = [[63.5, 24.75], [78.5, 24.75], [78.5, 34.75], [63.5, 34.75]];  // pocket at grid node 1,1, 4 points

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
