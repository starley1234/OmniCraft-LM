$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 4 voids, 90 x 80 x 6 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 90;             // plate length, X
plate_w = 80;             // plate width, Y
plate_t = 6;              // plate thickness, Z
edge_margin = 8;          // wall from the plate edge to any window
win_l = 18;               // pocket length
win_w = 12;               // pocket width
pitch_x = 37;             // grid pitch along X
pitch_y = 32;             // grid pitch along Y
depth_1 = 6;              // depth of void 1 (full thickness = through)
depth_2 = 6;              // depth of void 2 (full thickness = through)
depth_3 = 6;              // depth of void 3 (full thickness = through)
depth_4 = 6;              // depth of void 4 (full thickness = through)
corner_c = 2.5;           // corner chamfer of the plate
fit_tol = 0.02;           // declared fit tolerance (prompt contract)
free_tol = 0.2;           // declared free tolerance (prompt contract)

profile = [[2.5, 0], [87.5, 0], [90, 2.5], [90, 77.5], [87.5, 80], [2.5, 80], [0, 77.5], [0, 2.5]];  // primary outline, 8 points, counter clockwise
void_1 = [[17.5, 18], [35.5, 18], [35.5, 30], [17.5, 30]];  // pocket at grid node 0,0, 4 points
void_2 = [[17.5, 50], [35.5, 50], [35.5, 62], [17.5, 62]];  // pocket at grid node 0,1, 4 points
void_3 = [[54.5, 18], [72.5, 18], [72.5, 30], [54.5, 30]];  // pocket at grid node 1,0, 4 points
void_4 = [[54.5, 50], [72.5, 50], [72.5, 62], [54.5, 62]];  // pocket at grid node 1,1, 4 points

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
