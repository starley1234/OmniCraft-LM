$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 4 voids, 100 x 80 x 8 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 100;            // plate length, X
plate_w = 80;             // plate width, Y
plate_t = 8;              // plate thickness, Z
edge_margin = 10;         // wall from the plate edge to any window
win_l = 12;               // pocket length
win_w = 12;               // pocket width
pitch_x = 40;             // grid pitch along X
pitch_y = 30;             // grid pitch along Y
depth_1 = 6.2;            // depth of void 1 (full thickness = through)
depth_2 = 2.1;            // depth of void 2 (full thickness = through)
depth_3 = 5.9;            // depth of void 3 (full thickness = through)
depth_4 = 1.5;            // depth of void 4 (full thickness = through)
corner_c = 5;             // corner chamfer of the plate

profile = [[5, 0], [95, 0], [100, 5], [100, 75], [95, 80], [5, 80], [0, 75], [0, 5]];  // primary outline, 8 points, counter clockwise
void_1 = [[24, 19], [36, 19], [36, 31], [24, 31]];  // pocket at grid node 0,0, 4 points
void_2 = [[24, 49], [36, 49], [36, 61], [24, 61]];  // pocket at grid node 0,1, 4 points
void_3 = [[64, 19], [76, 19], [76, 31], [64, 31]];  // pocket at grid node 1,0, 4 points
void_4 = [[64, 49], [76, 49], [76, 61], [64, 61]];  // pocket at grid node 1,1, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
  translate([0, 0, plate_t - depth_2])
    linear_extrude(height = depth_2 + 1) polygon(points = void_2);
  translate([0, 0, plate_t - depth_3])
    linear_extrude(height = depth_3 + 1) polygon(points = void_3);
  translate([0, 0, plate_t - depth_4])
    linear_extrude(height = depth_4 + 1) polygon(points = void_4);
}
