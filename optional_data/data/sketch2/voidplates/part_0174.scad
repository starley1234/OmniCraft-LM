$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 4 voids, 70 x 80 x 10 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 70;             // plate length, X
plate_w = 80;             // plate width, Y
plate_t = 10;             // plate thickness, Z
edge_margin = 8;          // wall from the plate edge to any window
win_l = 18;               // pocket length
win_w = 14;               // pocket width
pitch_x = 27;             // grid pitch along X
pitch_y = 32;             // grid pitch along Y
depth_1 = 10;             // depth of void 1 (full thickness = through)
depth_2 = 10;             // depth of void 2 (full thickness = through)
depth_3 = 10;             // depth of void 3 (full thickness = through)
depth_4 = 10;             // depth of void 4 (full thickness = through)
corner_c = 4;             // corner chamfer of the plate

profile = [[4, 0], [66, 0], [70, 4], [70, 76], [66, 80], [4, 80], [0, 76], [0, 4]];  // primary outline, 8 points, counter clockwise
void_1 = [[12.5, 17], [30.5, 17], [30.5, 31], [12.5, 31]];  // pocket at grid node 0,0, 4 points
void_2 = [[12.5, 49], [30.5, 49], [30.5, 63], [12.5, 63]];  // pocket at grid node 0,1, 4 points
void_3 = [[39.5, 17], [57.5, 17], [57.5, 31], [39.5, 31]];  // pocket at grid node 1,0, 4 points
void_4 = [[39.5, 49], [57.5, 49], [57.5, 63], [39.5, 63]];  // pocket at grid node 1,1, 4 points

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
