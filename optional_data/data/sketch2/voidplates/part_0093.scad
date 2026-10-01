$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 4 voids, 90 x 60 x 5 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 90;             // plate length, X
plate_w = 60;             // plate width, Y
plate_t = 5;              // plate thickness, Z
edge_margin = 10;         // wall from the plate edge to any window
win_l = 12;               // pocket length
win_w = 12;               // pocket width
pitch_x = 35;             // grid pitch along X
pitch_y = 20;             // grid pitch along Y
depth_1 = 5;              // depth of void 1 (full thickness = through)
depth_2 = 5;              // depth of void 2 (full thickness = through)
depth_3 = 5;              // depth of void 3 (full thickness = through)
depth_4 = 5;              // depth of void 4 (full thickness = through)
corner_c = 2;             // corner chamfer of the plate

profile = [[2, 0], [88, 0], [90, 2], [90, 58], [88, 60], [2, 60], [0, 58], [0, 2]];  // primary outline, 8 points, counter clockwise
void_1 = [[21.5, 14], [33.5, 14], [33.5, 26], [21.5, 26]];  // pocket at grid node 0,0, 4 points
void_2 = [[21.5, 34], [33.5, 34], [33.5, 46], [21.5, 46]];  // pocket at grid node 0,1, 4 points
void_3 = [[56.5, 14], [68.5, 14], [68.5, 26], [56.5, 26]];  // pocket at grid node 1,0, 4 points
void_4 = [[56.5, 34], [68.5, 34], [68.5, 46], [56.5, 46]];  // pocket at grid node 1,1, 4 points

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
