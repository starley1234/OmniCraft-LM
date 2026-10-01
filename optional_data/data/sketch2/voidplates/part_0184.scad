$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 4 voids, 90 x 60 x 10 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 90;             // plate length, X
plate_w = 60;             // plate width, Y
plate_t = 10;             // plate thickness, Z
edge_margin = 8;          // wall from the plate edge to any window
win_l = 18;               // pocket length
win_w = 14;               // pocket width
pitch_x = 37;             // grid pitch along X
pitch_y = 22;             // grid pitch along Y
depth_1 = 2.5;            // depth of void 1 (full thickness = through)
depth_2 = 10;             // depth of void 2 (full thickness = through)
depth_3 = 3.2;            // depth of void 3 (full thickness = through)
depth_4 = 3.9;            // depth of void 4 (full thickness = through)
corner_c = 5;             // corner chamfer of the plate

profile = [[5, 0], [85, 0], [90, 5], [90, 55], [85, 60], [5, 60], [0, 55], [0, 5]];  // primary outline, 8 points, counter clockwise
void_1 = [[17.5, 12], [35.5, 12], [35.5, 26], [17.5, 26]];  // pocket at grid node 0,0, 4 points
void_2 = [[17.5, 34], [35.5, 34], [35.5, 48], [17.5, 48]];  // pocket at grid node 0,1, 4 points
void_3 = [[54.5, 12], [72.5, 12], [72.5, 26], [54.5, 26]];  // pocket at grid node 1,0, 4 points
void_4 = [[54.5, 34], [72.5, 34], [72.5, 48], [54.5, 48]];  // pocket at grid node 1,1, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_2);
  translate([0, 0, plate_t - depth_3])
    linear_extrude(height = depth_3 + 1) polygon(points = void_3);
  translate([0, 0, plate_t - depth_4])
    linear_extrude(height = depth_4 + 1) polygon(points = void_4);
}
