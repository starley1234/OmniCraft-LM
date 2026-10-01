$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 4 voids, 120 x 70 x 8 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 120;            // plate length, X
plate_w = 70;             // plate width, Y
plate_t = 8;              // plate thickness, Z
edge_margin = 12;         // wall from the plate edge to any window
win_l = 15;               // pocket length
win_w = 14;               // pocket width
pitch_x = 48;             // grid pitch along X
pitch_y = 23;             // grid pitch along Y
depth_1 = 4.8;            // depth of void 1 (full thickness = through)
depth_2 = 3.7;            // depth of void 2 (full thickness = through)
depth_3 = 3.2;            // depth of void 3 (full thickness = through)
depth_4 = 5.5;            // depth of void 4 (full thickness = through)
corner_c = 4;             // corner chamfer of the plate

profile = [[4, 0], [116, 0], [120, 4], [120, 66], [116, 70], [4, 70], [0, 66], [0, 4]];  // primary outline, 8 points, counter clockwise
void_1 = [[28.5, 16.5], [43.5, 16.5], [43.5, 30.5], [28.5, 30.5]];  // pocket at grid node 0,0, 4 points
void_2 = [[28.5, 39.5], [43.5, 39.5], [43.5, 53.5], [28.5, 53.5]];  // pocket at grid node 0,1, 4 points
void_3 = [[76.5, 16.5], [91.5, 16.5], [91.5, 30.5], [76.5, 30.5]];  // pocket at grid node 1,0, 4 points
void_4 = [[76.5, 39.5], [91.5, 39.5], [91.5, 53.5], [76.5, 53.5]];  // pocket at grid node 1,1, 4 points

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
