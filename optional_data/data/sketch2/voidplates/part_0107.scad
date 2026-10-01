$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 4 voids, 90 x 70 x 8 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 90;             // plate length, X
plate_w = 70;             // plate width, Y
plate_t = 8;              // plate thickness, Z
edge_margin = 12;         // wall from the plate edge to any window
win_l = 18;               // pocket length
win_w = 12;               // pocket width
pitch_x = 33;             // grid pitch along X
pitch_y = 23;             // grid pitch along Y
depth_1 = 4.5;            // depth of void 1 (full thickness = through)
depth_2 = 3.8;            // depth of void 2 (full thickness = through)
depth_3 = 5.6;            // depth of void 3 (full thickness = through)
depth_4 = 1.8;            // depth of void 4 (full thickness = through)
corner_c = 2.5;           // corner chamfer of the plate

profile = [[2.5, 0], [87.5, 0], [90, 2.5], [90, 67.5], [87.5, 70], [2.5, 70], [0, 67.5], [0, 2.5]];  // primary outline, 8 points, counter clockwise
void_1 = [[19.5, 17.5], [37.5, 17.5], [37.5, 29.5], [19.5, 29.5]];  // pocket at grid node 0,0, 4 points
void_2 = [[19.5, 40.5], [37.5, 40.5], [37.5, 52.5], [19.5, 52.5]];  // pocket at grid node 0,1, 4 points
void_3 = [[52.5, 17.5], [70.5, 17.5], [70.5, 29.5], [52.5, 29.5]];  // pocket at grid node 1,0, 4 points
void_4 = [[52.5, 40.5], [70.5, 40.5], [70.5, 52.5], [52.5, 52.5]];  // pocket at grid node 1,1, 4 points

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
