$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 4 voids, 70 x 80 x 6 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 70;             // plate length, X
plate_w = 80;             // plate width, Y
plate_t = 6;              // plate thickness, Z
edge_margin = 8;          // wall from the plate edge to any window
win_l = 18;               // pocket length
win_w = 10;               // pocket width
pitch_x = 27;             // grid pitch along X
pitch_y = 32;             // grid pitch along Y
depth_1 = 2.5;            // depth of void 1 (full thickness = through)
depth_2 = 6;              // depth of void 2 (full thickness = through)
depth_3 = 3.1;            // depth of void 3 (full thickness = through)
depth_4 = 6;              // depth of void 4 (full thickness = through)
corner_c = 3;             // corner chamfer of the plate

profile = [[3, 0], [67, 0], [70, 3], [70, 77], [67, 80], [3, 80], [0, 77], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[12.5, 19], [30.5, 19], [30.5, 29], [12.5, 29]];  // pocket at grid node 0,0, 4 points
void_2 = [[12.5, 51], [30.5, 51], [30.5, 61], [12.5, 61]];  // pocket at grid node 0,1, 4 points
void_3 = [[39.5, 19], [57.5, 19], [57.5, 29], [39.5, 29]];  // pocket at grid node 1,0, 4 points
void_4 = [[39.5, 51], [57.5, 51], [57.5, 61], [39.5, 61]];  // pocket at grid node 1,1, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_2);
  translate([0, 0, plate_t - depth_3])
    linear_extrude(height = depth_3 + 1) polygon(points = void_3);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_4);
}
