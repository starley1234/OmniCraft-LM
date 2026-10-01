$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 4 voids, 70 x 70 x 6 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 70;             // plate length, X
plate_w = 70;             // plate width, Y
plate_t = 6;              // plate thickness, Z
edge_margin = 10;         // wall from the plate edge to any window
win_l = 18;               // pocket length
win_w = 10;               // pocket width
pitch_x = 25;             // grid pitch along X
pitch_y = 25;             // grid pitch along Y
depth_1 = 3.8;            // depth of void 1 (full thickness = through)
depth_2 = 3.9;            // depth of void 2 (full thickness = through)
depth_3 = 4.5;            // depth of void 3 (full thickness = through)
depth_4 = 3.4;            // depth of void 4 (full thickness = through)
corner_c = 4;             // corner chamfer of the plate

profile = [[4, 0], [66, 0], [70, 4], [70, 66], [66, 70], [4, 70], [0, 66], [0, 4]];  // primary outline, 8 points, counter clockwise
void_1 = [[13.5, 17.5], [31.5, 17.5], [31.5, 27.5], [13.5, 27.5]];  // pocket at grid node 0,0, 4 points
void_2 = [[13.5, 42.5], [31.5, 42.5], [31.5, 52.5], [13.5, 52.5]];  // pocket at grid node 0,1, 4 points
void_3 = [[38.5, 17.5], [56.5, 17.5], [56.5, 27.5], [38.5, 27.5]];  // pocket at grid node 1,0, 4 points
void_4 = [[38.5, 42.5], [56.5, 42.5], [56.5, 52.5], [38.5, 52.5]];  // pocket at grid node 1,1, 4 points

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
