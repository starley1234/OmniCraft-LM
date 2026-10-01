$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 4 voids, 70 x 70 x 8 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 70;             // plate length, X
plate_w = 70;             // plate width, Y
plate_t = 8;              // plate thickness, Z
edge_margin = 10;         // wall from the plate edge to any window
win_l = 12;               // pocket length
win_w = 14;               // pocket width
pitch_x = 25;             // grid pitch along X
pitch_y = 25;             // grid pitch along Y
depth_1 = 8;              // depth of void 1 (full thickness = through)
depth_2 = 8;              // depth of void 2 (full thickness = through)
depth_3 = 8;              // depth of void 3 (full thickness = through)
depth_4 = 8;              // depth of void 4 (full thickness = through)
corner_c = 2.5;           // corner chamfer of the plate

profile = [[2.5, 0], [67.5, 0], [70, 2.5], [70, 67.5], [67.5, 70], [2.5, 70], [0, 67.5], [0, 2.5]];  // primary outline, 8 points, counter clockwise
void_1 = [[16.5, 15.5], [28.5, 15.5], [28.5, 29.5], [16.5, 29.5]];  // pocket at grid node 0,0, 4 points
void_2 = [[16.5, 40.5], [28.5, 40.5], [28.5, 54.5], [16.5, 54.5]];  // pocket at grid node 0,1, 4 points
void_3 = [[41.5, 15.5], [53.5, 15.5], [53.5, 29.5], [41.5, 29.5]];  // pocket at grid node 1,0, 4 points
void_4 = [[41.5, 40.5], [53.5, 40.5], [53.5, 54.5], [41.5, 54.5]];  // pocket at grid node 1,1, 4 points

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
