$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 4 voids, 110 x 70 x 8 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 110;            // plate length, X
plate_w = 70;             // plate width, Y
plate_t = 8;              // plate thickness, Z
edge_margin = 10;         // wall from the plate edge to any window
win_l = 15;               // pocket length
win_w = 14;               // pocket width
pitch_x = 45;             // grid pitch along X
pitch_y = 25;             // grid pitch along Y
depth_1 = 8;              // depth of void 1 (full thickness = through)
depth_2 = 8;              // depth of void 2 (full thickness = through)
depth_3 = 8;              // depth of void 3 (full thickness = through)
depth_4 = 8;              // depth of void 4 (full thickness = through)
corner_c = 4;             // corner chamfer of the plate

profile = [[4, 0], [106, 0], [110, 4], [110, 66], [106, 70], [4, 70], [0, 66], [0, 4]];  // primary outline, 8 points, counter clockwise
void_1 = [[25, 15.5], [40, 15.5], [40, 29.5], [25, 29.5]];  // pocket at grid node 0,0, 4 points
void_2 = [[25, 40.5], [40, 40.5], [40, 54.5], [25, 54.5]];  // pocket at grid node 0,1, 4 points
void_3 = [[70, 15.5], [85, 15.5], [85, 29.5], [70, 29.5]];  // pocket at grid node 1,0, 4 points
void_4 = [[70, 40.5], [85, 40.5], [85, 54.5], [70, 54.5]];  // pocket at grid node 1,1, 4 points

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
