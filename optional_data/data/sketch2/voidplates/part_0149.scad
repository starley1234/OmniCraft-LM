$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 4 voids, 100 x 70 x 5 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 100;            // plate length, X
plate_w = 70;             // plate width, Y
plate_t = 5;              // plate thickness, Z
edge_margin = 8;          // wall from the plate edge to any window
win_l = 18;               // pocket length
win_w = 12;               // pocket width
pitch_x = 42;             // grid pitch along X
pitch_y = 27;             // grid pitch along Y
depth_1 = 5;              // depth of void 1 (full thickness = through)
depth_2 = 5;              // depth of void 2 (full thickness = through)
depth_3 = 5;              // depth of void 3 (full thickness = through)
depth_4 = 5;              // depth of void 4 (full thickness = through)
corner_c = 4;             // corner chamfer of the plate

profile = [[4, 0], [96, 0], [100, 4], [100, 66], [96, 70], [4, 70], [0, 66], [0, 4]];  // primary outline, 8 points, counter clockwise
void_1 = [[20, 15.5], [38, 15.5], [38, 27.5], [20, 27.5]];  // pocket at grid node 0,0, 4 points
void_2 = [[20, 42.5], [38, 42.5], [38, 54.5], [20, 54.5]];  // pocket at grid node 0,1, 4 points
void_3 = [[62, 15.5], [80, 15.5], [80, 27.5], [62, 27.5]];  // pocket at grid node 1,0, 4 points
void_4 = [[62, 42.5], [80, 42.5], [80, 54.5], [62, 54.5]];  // pocket at grid node 1,1, 4 points

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
