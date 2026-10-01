$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 4 voids, 100 x 80 x 8 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 100;            // plate length, X
plate_w = 80;             // plate width, Y
plate_t = 8;              // plate thickness, Z
edge_margin = 8;          // wall from the plate edge to any window
win_l = 15;               // pocket length
win_w = 14;               // pocket width
pitch_x = 42;             // grid pitch along X
pitch_y = 32;             // grid pitch along Y
depth_1 = 2.1;            // depth of void 1 (full thickness = through)
depth_2 = 3;              // depth of void 2 (full thickness = through)
depth_3 = 4.6;            // depth of void 3 (full thickness = through)
depth_4 = 4.3;            // depth of void 4 (full thickness = through)
corner_c = 3;             // corner chamfer of the plate
fit_tol = 0.1;            // declared fit tolerance (prompt contract)
free_tol = 0.3;           // declared free tolerance (prompt contract)

profile = [[3, 0], [97, 0], [100, 3], [100, 77], [97, 80], [3, 80], [0, 77], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[21.5, 17], [36.5, 17], [36.5, 31], [21.5, 31]];  // pocket at grid node 0,0, 4 points
void_2 = [[21.5, 49], [36.5, 49], [36.5, 63], [21.5, 63]];  // pocket at grid node 0,1, 4 points
void_3 = [[63.5, 17], [78.5, 17], [78.5, 31], [63.5, 31]];  // pocket at grid node 1,0, 4 points
void_4 = [[63.5, 49], [78.5, 49], [78.5, 63], [63.5, 63]];  // pocket at grid node 1,1, 4 points

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
