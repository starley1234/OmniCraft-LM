$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 4 voids, 100 x 60 x 10 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 100;            // plate length, X
plate_w = 60;             // plate width, Y
plate_t = 10;             // plate thickness, Z
edge_margin = 8;          // wall from the plate edge to any window
win_l = 15;               // pocket length
win_w = 14;               // pocket width
pitch_x = 42;             // grid pitch along X
pitch_y = 22;             // grid pitch along Y
depth_1 = 6.1;            // depth of void 1 (full thickness = through)
depth_2 = 7;              // depth of void 2 (full thickness = through)
depth_3 = 2;              // depth of void 3 (full thickness = through)
depth_4 = 7.9;            // depth of void 4 (full thickness = through)
corner_c = 4;             // corner chamfer of the plate
fit_tol = 0.1;            // declared fit tolerance (prompt contract)
free_tol = 0.3;           // declared free tolerance (prompt contract)

profile = [[4, 0], [96, 0], [100, 4], [100, 56], [96, 60], [4, 60], [0, 56], [0, 4]];  // primary outline, 8 points, counter clockwise
void_1 = [[21.5, 12], [36.5, 12], [36.5, 26], [21.5, 26]];  // pocket at grid node 0,0, 4 points
void_2 = [[21.5, 34], [36.5, 34], [36.5, 48], [21.5, 48]];  // pocket at grid node 0,1, 4 points
void_3 = [[63.5, 12], [78.5, 12], [78.5, 26], [63.5, 26]];  // pocket at grid node 1,0, 4 points
void_4 = [[63.5, 34], [78.5, 34], [78.5, 48], [63.5, 48]];  // pocket at grid node 1,1, 4 points

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
