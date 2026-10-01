$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 4 voids, 90 x 60 x 10 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 90;             // plate length, X
plate_w = 60;             // plate width, Y
plate_t = 10;             // plate thickness, Z
edge_margin = 12;         // wall from the plate edge to any window
win_l = 12;               // pocket length
win_w = 14;               // pocket width
pitch_x = 33;             // grid pitch along X
pitch_y = 18;             // grid pitch along Y
depth_1 = 10;             // depth of void 1 (full thickness = through)
depth_2 = 10;             // depth of void 2 (full thickness = through)
depth_3 = 10;             // depth of void 3 (full thickness = through)
depth_4 = 10;             // depth of void 4 (full thickness = through)
corner_c = 3;             // corner chamfer of the plate

profile = [[3, 0], [87, 0], [90, 3], [90, 57], [87, 60], [3, 60], [0, 57], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[22.5, 14], [34.5, 14], [34.5, 28], [22.5, 28]];  // pocket at grid node 0,0, 4 points
void_2 = [[22.5, 32], [34.5, 32], [34.5, 46], [22.5, 46]];  // pocket at grid node 0,1, 4 points
void_3 = [[55.5, 14], [67.5, 14], [67.5, 28], [55.5, 28]];  // pocket at grid node 1,0, 4 points
void_4 = [[55.5, 32], [67.5, 32], [67.5, 46], [55.5, 46]];  // pocket at grid node 1,1, 4 points

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
