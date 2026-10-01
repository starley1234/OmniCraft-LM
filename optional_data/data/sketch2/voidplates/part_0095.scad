$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 4 voids, 70 x 70 x 10 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 70;             // plate length, X
plate_w = 70;             // plate width, Y
plate_t = 10;             // plate thickness, Z
edge_margin = 8;          // wall from the plate edge to any window
win_l = 15;               // pocket length
win_w = 10;               // pocket width
pitch_x = 27;             // grid pitch along X
pitch_y = 27;             // grid pitch along Y
depth_1 = 10;             // depth of void 1 (full thickness = through)
depth_2 = 10;             // depth of void 2 (full thickness = through)
depth_3 = 10;             // depth of void 3 (full thickness = through)
depth_4 = 10;             // depth of void 4 (full thickness = through)
corner_c = 5;             // corner chamfer of the plate
fit_tol = 0.05;           // declared fit tolerance (prompt contract)
free_tol = 0.3;           // declared free tolerance (prompt contract)

profile = [[5, 0], [65, 0], [70, 5], [70, 65], [65, 70], [5, 70], [0, 65], [0, 5]];  // primary outline, 8 points, counter clockwise
void_1 = [[14, 16.5], [29, 16.5], [29, 26.5], [14, 26.5]];  // pocket at grid node 0,0, 4 points
void_2 = [[14, 43.5], [29, 43.5], [29, 53.5], [14, 53.5]];  // pocket at grid node 0,1, 4 points
void_3 = [[41, 16.5], [56, 16.5], [56, 26.5], [41, 26.5]];  // pocket at grid node 1,0, 4 points
void_4 = [[41, 43.5], [56, 43.5], [56, 53.5], [41, 53.5]];  // pocket at grid node 1,1, 4 points

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
