$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 4 voids, 110 x 50 x 5 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 110;            // plate length, X
plate_w = 50;             // plate width, Y
plate_t = 5;              // plate thickness, Z
edge_margin = 10;         // wall from the plate edge to any window
win_l = 18;               // pocket length
win_w = 10;               // pocket width
pitch_x = 45;             // grid pitch along X
pitch_y = 15;             // grid pitch along Y
depth_1 = 5;              // depth of void 1 (full thickness = through)
depth_2 = 5;              // depth of void 2 (full thickness = through)
depth_3 = 5;              // depth of void 3 (full thickness = through)
depth_4 = 5;              // depth of void 4 (full thickness = through)
corner_c = 4;             // corner chamfer of the plate

profile = [[4, 0], [106, 0], [110, 4], [110, 46], [106, 50], [4, 50], [0, 46], [0, 4]];  // primary outline, 8 points, counter clockwise
void_1 = [[23.5, 12.5], [41.5, 12.5], [41.5, 22.5], [23.5, 22.5]];  // pocket at grid node 0,0, 4 points
void_2 = [[23.5, 27.5], [41.5, 27.5], [41.5, 37.5], [23.5, 37.5]];  // pocket at grid node 0,1, 4 points
void_3 = [[68.5, 12.5], [86.5, 12.5], [86.5, 22.5], [68.5, 22.5]];  // pocket at grid node 1,0, 4 points
void_4 = [[68.5, 27.5], [86.5, 27.5], [86.5, 37.5], [68.5, 37.5]];  // pocket at grid node 1,1, 4 points

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
