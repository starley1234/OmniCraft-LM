$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 4 voids, 70 x 50 x 8 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 70;             // plate length, X
plate_w = 50;             // plate width, Y
plate_t = 8;              // plate thickness, Z
edge_margin = 8;          // wall from the plate edge to any window
win_l = 18;               // pocket length
win_w = 14;               // pocket width
pitch_x = 27;             // grid pitch along X
pitch_y = 17;             // grid pitch along Y
depth_1 = 8;              // depth of void 1 (full thickness = through)
depth_2 = 2.7;            // depth of void 2 (full thickness = through)
depth_3 = 6;              // depth of void 3 (full thickness = through)
depth_4 = 8;              // depth of void 4 (full thickness = through)
corner_c = 5;             // corner chamfer of the plate

profile = [[5, 0], [65, 0], [70, 5], [70, 45], [65, 50], [5, 50], [0, 45], [0, 5]];  // primary outline, 8 points, counter clockwise
void_1 = [[12.5, 9.5], [30.5, 9.5], [30.5, 23.5], [12.5, 23.5]];  // pocket at grid node 0,0, 4 points
void_2 = [[12.5, 26.5], [30.5, 26.5], [30.5, 40.5], [12.5, 40.5]];  // pocket at grid node 0,1, 4 points
void_3 = [[39.5, 9.5], [57.5, 9.5], [57.5, 23.5], [39.5, 23.5]];  // pocket at grid node 1,0, 4 points
void_4 = [[39.5, 26.5], [57.5, 26.5], [57.5, 40.5], [39.5, 40.5]];  // pocket at grid node 1,1, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
  translate([0, 0, plate_t - depth_2])
    linear_extrude(height = depth_2 + 1) polygon(points = void_2);
  translate([0, 0, plate_t - depth_3])
    linear_extrude(height = depth_3 + 1) polygon(points = void_3);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_4);
}
