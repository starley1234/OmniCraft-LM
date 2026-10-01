$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 4 voids, 70 x 70 x 5 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 70;             // plate length, X
plate_w = 70;             // plate width, Y
plate_t = 5;              // plate thickness, Z
edge_margin = 8;          // wall from the plate edge to any window
win_l = 15;               // pocket length
win_w = 12;               // pocket width
pitch_x = 27;             // grid pitch along X
pitch_y = 27;             // grid pitch along Y
depth_1 = 5;              // depth of void 1 (full thickness = through)
depth_2 = 5;              // depth of void 2 (full thickness = through)
depth_3 = 5;              // depth of void 3 (full thickness = through)
depth_4 = 5;              // depth of void 4 (full thickness = through)
corner_c = 2;             // corner chamfer of the plate
fit_tol = 0.02;           // declared fit tolerance (prompt contract)
free_tol = 0.2;           // declared free tolerance (prompt contract)

profile = [[2, 0], [68, 0], [70, 2], [70, 68], [68, 70], [2, 70], [0, 68], [0, 2]];  // primary outline, 8 points, counter clockwise
void_1 = [[14, 15.5], [29, 15.5], [29, 27.5], [14, 27.5]];  // pocket at grid node 0,0, 4 points
void_2 = [[14, 42.5], [29, 42.5], [29, 54.5], [14, 54.5]];  // pocket at grid node 0,1, 4 points
void_3 = [[41, 15.5], [56, 15.5], [56, 27.5], [41, 27.5]];  // pocket at grid node 1,0, 4 points
void_4 = [[41, 42.5], [56, 42.5], [56, 54.5], [41, 54.5]];  // pocket at grid node 1,1, 4 points

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
