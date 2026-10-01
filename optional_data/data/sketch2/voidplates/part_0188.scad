$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 4 voids, 80 x 70 x 10 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 80;             // plate length, X
plate_w = 70;             // plate width, Y
plate_t = 10;             // plate thickness, Z
edge_margin = 12;         // wall from the plate edge to any window
win_l = 12;               // pocket length
win_w = 10;               // pocket width
pitch_x = 28;             // grid pitch along X
pitch_y = 23;             // grid pitch along Y
depth_1 = 10;             // depth of void 1 (full thickness = through)
depth_2 = 10;             // depth of void 2 (full thickness = through)
depth_3 = 10;             // depth of void 3 (full thickness = through)
depth_4 = 10;             // depth of void 4 (full thickness = through)
corner_c = 3;             // corner chamfer of the plate

profile = [[3, 0], [77, 0], [80, 3], [80, 67], [77, 70], [3, 70], [0, 67], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[20, 18.5], [32, 18.5], [32, 28.5], [20, 28.5]];  // pocket at grid node 0,0, 4 points
void_2 = [[20, 41.5], [32, 41.5], [32, 51.5], [20, 51.5]];  // pocket at grid node 0,1, 4 points
void_3 = [[48, 18.5], [60, 18.5], [60, 28.5], [48, 28.5]];  // pocket at grid node 1,0, 4 points
void_4 = [[48, 41.5], [60, 41.5], [60, 51.5], [48, 51.5]];  // pocket at grid node 1,1, 4 points

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
