$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 4 voids, 70 x 60 x 6 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 70;             // plate length, X
plate_w = 60;             // plate width, Y
plate_t = 6;              // plate thickness, Z
edge_margin = 10;         // wall from the plate edge to any window
win_l = 12;               // pocket length
win_w = 10;               // pocket width
pitch_x = 25;             // grid pitch along X
pitch_y = 20;             // grid pitch along Y
depth_1 = 6;              // depth of void 1 (full thickness = through)
depth_2 = 6;              // depth of void 2 (full thickness = through)
depth_3 = 6;              // depth of void 3 (full thickness = through)
depth_4 = 6;              // depth of void 4 (full thickness = through)
corner_c = 3;             // corner chamfer of the plate

profile = [[3, 0], [67, 0], [70, 3], [70, 57], [67, 60], [3, 60], [0, 57], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[16.5, 15], [28.5, 15], [28.5, 25], [16.5, 25]];  // pocket at grid node 0,0, 4 points
void_2 = [[16.5, 35], [28.5, 35], [28.5, 45], [16.5, 45]];  // pocket at grid node 0,1, 4 points
void_3 = [[41.5, 15], [53.5, 15], [53.5, 25], [41.5, 25]];  // pocket at grid node 1,0, 4 points
void_4 = [[41.5, 35], [53.5, 35], [53.5, 45], [41.5, 45]];  // pocket at grid node 1,1, 4 points

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
