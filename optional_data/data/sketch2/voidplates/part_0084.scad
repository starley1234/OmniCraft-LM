$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 4 voids, 80 x 70 x 10 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 80;             // plate length, X
plate_w = 70;             // plate width, Y
plate_t = 10;             // plate thickness, Z
edge_margin = 10;         // wall from the plate edge to any window
win_l = 12;               // pocket length
win_w = 10;               // pocket width
pitch_x = 30;             // grid pitch along X
pitch_y = 25;             // grid pitch along Y
depth_1 = 10;             // depth of void 1 (full thickness = through)
depth_2 = 10;             // depth of void 2 (full thickness = through)
depth_3 = 10;             // depth of void 3 (full thickness = through)
depth_4 = 10;             // depth of void 4 (full thickness = through)
corner_c = 4;             // corner chamfer of the plate
fit_tol = 0.02;           // declared fit tolerance (prompt contract)
free_tol = 0.2;           // declared free tolerance (prompt contract)

profile = [[4, 0], [76, 0], [80, 4], [80, 66], [76, 70], [4, 70], [0, 66], [0, 4]];  // primary outline, 8 points, counter clockwise
void_1 = [[19, 17.5], [31, 17.5], [31, 27.5], [19, 27.5]];  // pocket at grid node 0,0, 4 points
void_2 = [[19, 42.5], [31, 42.5], [31, 52.5], [19, 52.5]];  // pocket at grid node 0,1, 4 points
void_3 = [[49, 17.5], [61, 17.5], [61, 27.5], [49, 27.5]];  // pocket at grid node 1,0, 4 points
void_4 = [[49, 42.5], [61, 42.5], [61, 52.5], [49, 52.5]];  // pocket at grid node 1,1, 4 points

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
