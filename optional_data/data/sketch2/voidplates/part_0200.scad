$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 4 voids, 110 x 70 x 5 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 110;            // plate length, X
plate_w = 70;             // plate width, Y
plate_t = 5;              // plate thickness, Z
edge_margin = 12;         // wall from the plate edge to any window
win_l = 18;               // pocket length
win_w = 12;               // pocket width
pitch_x = 43;             // grid pitch along X
pitch_y = 23;             // grid pitch along Y
depth_1 = 1.9;            // depth of void 1 (full thickness = through)
depth_2 = 2.2;            // depth of void 2 (full thickness = through)
depth_3 = 2;              // depth of void 3 (full thickness = through)
depth_4 = 3;              // depth of void 4 (full thickness = through)
corner_c = 2;             // corner chamfer of the plate

profile = [[2, 0], [108, 0], [110, 2], [110, 68], [108, 70], [2, 70], [0, 68], [0, 2]];  // primary outline, 8 points, counter clockwise
void_1 = [[24.5, 17.5], [42.5, 17.5], [42.5, 29.5], [24.5, 29.5]];  // pocket at grid node 0,0, 4 points
void_2 = [[24.5, 40.5], [42.5, 40.5], [42.5, 52.5], [24.5, 52.5]];  // pocket at grid node 0,1, 4 points
void_3 = [[67.5, 17.5], [85.5, 17.5], [85.5, 29.5], [67.5, 29.5]];  // pocket at grid node 1,0, 4 points
void_4 = [[67.5, 40.5], [85.5, 40.5], [85.5, 52.5], [67.5, 52.5]];  // pocket at grid node 1,1, 4 points

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
