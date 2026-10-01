$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 4 voids, 120 x 70 x 8 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 120;            // plate length, X
plate_w = 70;             // plate width, Y
plate_t = 8;              // plate thickness, Z
edge_margin = 8;          // wall from the plate edge to any window
win_l = 15;               // pocket length
win_w = 12;               // pocket width
pitch_x = 52;             // grid pitch along X
pitch_y = 27;             // grid pitch along Y
depth_1 = 8;              // depth of void 1 (full thickness = through)
depth_2 = 8;              // depth of void 2 (full thickness = through)
depth_3 = 8;              // depth of void 3 (full thickness = through)
depth_4 = 8;              // depth of void 4 (full thickness = through)
corner_c = 5;             // corner chamfer of the plate

profile = [[5, 0], [115, 0], [120, 5], [120, 65], [115, 70], [5, 70], [0, 65], [0, 5]];  // primary outline, 8 points, counter clockwise
void_1 = [[26.5, 15.5], [41.5, 15.5], [41.5, 27.5], [26.5, 27.5]];  // pocket at grid node 0,0, 4 points
void_2 = [[26.5, 42.5], [41.5, 42.5], [41.5, 54.5], [26.5, 54.5]];  // pocket at grid node 0,1, 4 points
void_3 = [[78.5, 15.5], [93.5, 15.5], [93.5, 27.5], [78.5, 27.5]];  // pocket at grid node 1,0, 4 points
void_4 = [[78.5, 42.5], [93.5, 42.5], [93.5, 54.5], [78.5, 54.5]];  // pocket at grid node 1,1, 4 points

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
