$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 4 voids, 120 x 70 x 5 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 120;            // plate length, X
plate_w = 70;             // plate width, Y
plate_t = 5;              // plate thickness, Z
edge_margin = 12;         // wall from the plate edge to any window
win_l = 12;               // pocket length
win_w = 12;               // pocket width
pitch_x = 48;             // grid pitch along X
pitch_y = 23;             // grid pitch along Y
depth_1 = 1.8;            // depth of void 1 (full thickness = through)
depth_2 = 5;              // depth of void 2 (full thickness = through)
depth_3 = 1.6;            // depth of void 3 (full thickness = through)
depth_4 = 5;              // depth of void 4 (full thickness = through)
corner_c = 5;             // corner chamfer of the plate

profile = [[5, 0], [115, 0], [120, 5], [120, 65], [115, 70], [5, 70], [0, 65], [0, 5]];  // primary outline, 8 points, counter clockwise
void_1 = [[30, 17.5], [42, 17.5], [42, 29.5], [30, 29.5]];  // pocket at grid node 0,0, 4 points
void_2 = [[30, 40.5], [42, 40.5], [42, 52.5], [30, 52.5]];  // pocket at grid node 0,1, 4 points
void_3 = [[78, 17.5], [90, 17.5], [90, 29.5], [78, 29.5]];  // pocket at grid node 1,0, 4 points
void_4 = [[78, 40.5], [90, 40.5], [90, 52.5], [78, 52.5]];  // pocket at grid node 1,1, 4 points

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
