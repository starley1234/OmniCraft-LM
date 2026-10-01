$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 4 voids, 70 x 60 x 6 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 70;             // plate length, X
plate_w = 60;             // plate width, Y
plate_t = 6;              // plate thickness, Z
edge_margin = 10;         // wall from the plate edge to any window
win_l = 18;               // pocket length
win_w = 12;               // pocket width
pitch_x = 25;             // grid pitch along X
pitch_y = 20;             // grid pitch along Y
depth_1 = 3.1;            // depth of void 1 (full thickness = through)
depth_2 = 4;              // depth of void 2 (full thickness = through)
depth_3 = 4.1;            // depth of void 3 (full thickness = through)
depth_4 = 2.1;            // depth of void 4 (full thickness = through)
corner_c = 4;             // corner chamfer of the plate

profile = [[4, 0], [66, 0], [70, 4], [70, 56], [66, 60], [4, 60], [0, 56], [0, 4]];  // primary outline, 8 points, counter clockwise
void_1 = [[13.5, 14], [31.5, 14], [31.5, 26], [13.5, 26]];  // pocket at grid node 0,0, 4 points
void_2 = [[13.5, 34], [31.5, 34], [31.5, 46], [13.5, 46]];  // pocket at grid node 0,1, 4 points
void_3 = [[38.5, 14], [56.5, 14], [56.5, 26], [38.5, 26]];  // pocket at grid node 1,0, 4 points
void_4 = [[38.5, 34], [56.5, 34], [56.5, 46], [38.5, 46]];  // pocket at grid node 1,1, 4 points

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
