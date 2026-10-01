$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 4 voids, 80 x 60 x 8 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 80;             // plate length, X
plate_w = 60;             // plate width, Y
plate_t = 8;              // plate thickness, Z
edge_margin = 10;         // wall from the plate edge to any window
win_l = 15;               // pocket length
win_w = 10;               // pocket width
pitch_x = 30;             // grid pitch along X
pitch_y = 20;             // grid pitch along Y
depth_1 = 5.1;            // depth of void 1 (full thickness = through)
depth_2 = 4.8;            // depth of void 2 (full thickness = through)
depth_3 = 2.9;            // depth of void 3 (full thickness = through)
depth_4 = 6.2;            // depth of void 4 (full thickness = through)
corner_c = 3;             // corner chamfer of the plate

profile = [[3, 0], [77, 0], [80, 3], [80, 57], [77, 60], [3, 60], [0, 57], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[17.5, 15], [32.5, 15], [32.5, 25], [17.5, 25]];  // pocket at grid node 0,0, 4 points
void_2 = [[17.5, 35], [32.5, 35], [32.5, 45], [17.5, 45]];  // pocket at grid node 0,1, 4 points
void_3 = [[47.5, 15], [62.5, 15], [62.5, 25], [47.5, 25]];  // pocket at grid node 1,0, 4 points
void_4 = [[47.5, 35], [62.5, 35], [62.5, 45], [47.5, 45]];  // pocket at grid node 1,1, 4 points

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
