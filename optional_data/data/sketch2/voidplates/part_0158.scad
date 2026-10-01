$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 4 voids, 120 x 60 x 5 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 120;            // plate length, X
plate_w = 60;             // plate width, Y
plate_t = 5;              // plate thickness, Z
edge_margin = 10;         // wall from the plate edge to any window
win_l = 12;               // pocket length
win_w = 14;               // pocket width
pitch_x = 50;             // grid pitch along X
pitch_y = 20;             // grid pitch along Y
depth_1 = 5;              // depth of void 1 (full thickness = through)
depth_2 = 5;              // depth of void 2 (full thickness = through)
depth_3 = 5;              // depth of void 3 (full thickness = through)
depth_4 = 5;              // depth of void 4 (full thickness = through)
corner_c = 4;             // corner chamfer of the plate

profile = [[4, 0], [116, 0], [120, 4], [120, 56], [116, 60], [4, 60], [0, 56], [0, 4]];  // primary outline, 8 points, counter clockwise
void_1 = [[29, 13], [41, 13], [41, 27], [29, 27]];  // pocket at grid node 0,0, 4 points
void_2 = [[29, 33], [41, 33], [41, 47], [29, 47]];  // pocket at grid node 0,1, 4 points
void_3 = [[79, 13], [91, 13], [91, 27], [79, 27]];  // pocket at grid node 1,0, 4 points
void_4 = [[79, 33], [91, 33], [91, 47], [79, 47]];  // pocket at grid node 1,1, 4 points

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
