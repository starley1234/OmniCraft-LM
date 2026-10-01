$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 4 voids, 100 x 70 x 6 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 100;            // plate length, X
plate_w = 70;             // plate width, Y
plate_t = 6;              // plate thickness, Z
edge_margin = 10;         // wall from the plate edge to any window
win_l = 12;               // pocket length
win_w = 12;               // pocket width
pitch_x = 40;             // grid pitch along X
pitch_y = 25;             // grid pitch along Y
depth_1 = 2.5;            // depth of void 1 (full thickness = through)
depth_2 = 2.4;            // depth of void 2 (full thickness = through)
depth_3 = 3;              // depth of void 3 (full thickness = through)
depth_4 = 4.2;            // depth of void 4 (full thickness = through)
corner_c = 5;             // corner chamfer of the plate

profile = [[5, 0], [95, 0], [100, 5], [100, 65], [95, 70], [5, 70], [0, 65], [0, 5]];  // primary outline, 8 points, counter clockwise
void_1 = [[24, 16.5], [36, 16.5], [36, 28.5], [24, 28.5]];  // pocket at grid node 0,0, 4 points
void_2 = [[24, 41.5], [36, 41.5], [36, 53.5], [24, 53.5]];  // pocket at grid node 0,1, 4 points
void_3 = [[64, 16.5], [76, 16.5], [76, 28.5], [64, 28.5]];  // pocket at grid node 1,0, 4 points
void_4 = [[64, 41.5], [76, 41.5], [76, 53.5], [64, 53.5]];  // pocket at grid node 1,1, 4 points

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
