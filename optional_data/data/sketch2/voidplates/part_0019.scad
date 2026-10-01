$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 4 voids, 90 x 70 x 6 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 90;             // plate length, X
plate_w = 70;             // plate width, Y
plate_t = 6;              // plate thickness, Z
edge_margin = 8;          // wall from the plate edge to any window
win_l = 15;               // pocket length
win_w = 10;               // pocket width
pitch_x = 37;             // grid pitch along X
pitch_y = 27;             // grid pitch along Y
depth_1 = 6;              // depth of void 1 (full thickness = through)
depth_2 = 6;              // depth of void 2 (full thickness = through)
depth_3 = 6;              // depth of void 3 (full thickness = through)
depth_4 = 6;              // depth of void 4 (full thickness = through)
corner_c = 2.5;           // corner chamfer of the plate

profile = [[2.5, 0], [87.5, 0], [90, 2.5], [90, 67.5], [87.5, 70], [2.5, 70], [0, 67.5], [0, 2.5]];  // primary outline, 8 points, counter clockwise
void_1 = [[19, 16.5], [34, 16.5], [34, 26.5], [19, 26.5]];  // pocket at grid node 0,0, 4 points
void_2 = [[19, 43.5], [34, 43.5], [34, 53.5], [19, 53.5]];  // pocket at grid node 0,1, 4 points
void_3 = [[56, 16.5], [71, 16.5], [71, 26.5], [56, 26.5]];  // pocket at grid node 1,0, 4 points
void_4 = [[56, 43.5], [71, 43.5], [71, 53.5], [56, 53.5]];  // pocket at grid node 1,1, 4 points

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
