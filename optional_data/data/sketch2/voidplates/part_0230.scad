$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 4 voids, 90 x 70 x 5 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 90;             // plate length, X
plate_w = 70;             // plate width, Y
plate_t = 5;              // plate thickness, Z
edge_margin = 12;         // wall from the plate edge to any window
win_l = 15;               // pocket length
win_w = 10;               // pocket width
pitch_x = 33;             // grid pitch along X
pitch_y = 23;             // grid pitch along Y
depth_1 = 3;              // depth of void 1 (full thickness = through)
depth_2 = 2.4;            // depth of void 2 (full thickness = through)
depth_3 = 1.7;            // depth of void 3 (full thickness = through)
depth_4 = 1.8;            // depth of void 4 (full thickness = through)
corner_c = 4;             // corner chamfer of the plate

profile = [[4, 0], [86, 0], [90, 4], [90, 66], [86, 70], [4, 70], [0, 66], [0, 4]];  // primary outline, 8 points, counter clockwise
void_1 = [[21, 18.5], [36, 18.5], [36, 28.5], [21, 28.5]];  // pocket at grid node 0,0, 4 points
void_2 = [[21, 41.5], [36, 41.5], [36, 51.5], [21, 51.5]];  // pocket at grid node 0,1, 4 points
void_3 = [[54, 18.5], [69, 18.5], [69, 28.5], [54, 28.5]];  // pocket at grid node 1,0, 4 points
void_4 = [[54, 41.5], [69, 41.5], [69, 51.5], [54, 51.5]];  // pocket at grid node 1,1, 4 points

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
