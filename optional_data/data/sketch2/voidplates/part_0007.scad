$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 4 voids, 90 x 50 x 10 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 90;             // plate length, X
plate_w = 50;             // plate width, Y
plate_t = 10;             // plate thickness, Z
edge_margin = 10;         // wall from the plate edge to any window
win_l = 12;               // pocket length
win_w = 12;               // pocket width
pitch_x = 35;             // grid pitch along X
pitch_y = 15;             // grid pitch along Y
depth_1 = 10;             // depth of void 1 (full thickness = through)
depth_2 = 10;             // depth of void 2 (full thickness = through)
depth_3 = 10;             // depth of void 3 (full thickness = through)
depth_4 = 10;             // depth of void 4 (full thickness = through)
corner_c = 5;             // corner chamfer of the plate

profile = [[5, 0], [85, 0], [90, 5], [90, 45], [85, 50], [5, 50], [0, 45], [0, 5]];  // primary outline, 8 points, counter clockwise
void_1 = [[21.5, 11.5], [33.5, 11.5], [33.5, 23.5], [21.5, 23.5]];  // pocket at grid node 0,0, 4 points
void_2 = [[21.5, 26.5], [33.5, 26.5], [33.5, 38.5], [21.5, 38.5]];  // pocket at grid node 0,1, 4 points
void_3 = [[56.5, 11.5], [68.5, 11.5], [68.5, 23.5], [56.5, 23.5]];  // pocket at grid node 1,0, 4 points
void_4 = [[56.5, 26.5], [68.5, 26.5], [68.5, 38.5], [56.5, 38.5]];  // pocket at grid node 1,1, 4 points

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
