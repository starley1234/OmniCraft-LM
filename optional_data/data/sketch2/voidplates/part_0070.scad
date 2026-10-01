$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 4 voids, 80 x 60 x 10 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 80;             // plate length, X
plate_w = 60;             // plate width, Y
plate_t = 10;             // plate thickness, Z
edge_margin = 8;          // wall from the plate edge to any window
win_l = 15;               // pocket length
win_w = 14;               // pocket width
pitch_x = 32;             // grid pitch along X
pitch_y = 22;             // grid pitch along Y
depth_1 = 3;              // depth of void 1 (full thickness = through)
depth_2 = 3;              // depth of void 2 (full thickness = through)
depth_3 = 2.3;            // depth of void 3 (full thickness = through)
depth_4 = 10;             // depth of void 4 (full thickness = through)
corner_c = 5;             // corner chamfer of the plate

profile = [[5, 0], [75, 0], [80, 5], [80, 55], [75, 60], [5, 60], [0, 55], [0, 5]];  // primary outline, 8 points, counter clockwise
void_1 = [[16.5, 12], [31.5, 12], [31.5, 26], [16.5, 26]];  // pocket at grid node 0,0, 4 points
void_2 = [[16.5, 34], [31.5, 34], [31.5, 48], [16.5, 48]];  // pocket at grid node 0,1, 4 points
void_3 = [[48.5, 12], [63.5, 12], [63.5, 26], [48.5, 26]];  // pocket at grid node 1,0, 4 points
void_4 = [[48.5, 34], [63.5, 34], [63.5, 48], [48.5, 48]];  // pocket at grid node 1,1, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
  translate([0, 0, plate_t - depth_2])
    linear_extrude(height = depth_2 + 1) polygon(points = void_2);
  translate([0, 0, plate_t - depth_3])
    linear_extrude(height = depth_3 + 1) polygon(points = void_3);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_4);
}
