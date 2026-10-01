$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 4 voids, 120 x 60 x 10 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 120;            // plate length, X
plate_w = 60;             // plate width, Y
plate_t = 10;             // plate thickness, Z
edge_margin = 10;         // wall from the plate edge to any window
win_l = 12;               // pocket length
win_w = 10;               // pocket width
pitch_x = 50;             // grid pitch along X
pitch_y = 20;             // grid pitch along Y
depth_1 = 4.7;            // depth of void 1 (full thickness = through)
depth_2 = 10;             // depth of void 2 (full thickness = through)
depth_3 = 10;             // depth of void 3 (full thickness = through)
depth_4 = 6;              // depth of void 4 (full thickness = through)
corner_c = 4;             // corner chamfer of the plate

profile = [[4, 0], [116, 0], [120, 4], [120, 56], [116, 60], [4, 60], [0, 56], [0, 4]];  // primary outline, 8 points, counter clockwise
void_1 = [[29, 15], [41, 15], [41, 25], [29, 25]];  // pocket at grid node 0,0, 4 points
void_2 = [[29, 35], [41, 35], [41, 45], [29, 45]];  // pocket at grid node 0,1, 4 points
void_3 = [[79, 15], [91, 15], [91, 25], [79, 25]];  // pocket at grid node 1,0, 4 points
void_4 = [[79, 35], [91, 35], [91, 45], [79, 45]];  // pocket at grid node 1,1, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_2);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_3);
  translate([0, 0, plate_t - depth_4])
    linear_extrude(height = depth_4 + 1) polygon(points = void_4);
}
