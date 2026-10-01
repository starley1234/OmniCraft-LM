$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 4 voids, 110 x 50 x 6 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 110;            // plate length, X
plate_w = 50;             // plate width, Y
plate_t = 6;              // plate thickness, Z
edge_margin = 8;          // wall from the plate edge to any window
win_l = 18;               // pocket length
win_w = 10;               // pocket width
pitch_x = 47;             // grid pitch along X
pitch_y = 17;             // grid pitch along Y
depth_1 = 6;              // depth of void 1 (full thickness = through)
depth_2 = 2.8;            // depth of void 2 (full thickness = through)
depth_3 = 6;              // depth of void 3 (full thickness = through)
depth_4 = 6;              // depth of void 4 (full thickness = through)
corner_c = 5;             // corner chamfer of the plate

profile = [[5, 0], [105, 0], [110, 5], [110, 45], [105, 50], [5, 50], [0, 45], [0, 5]];  // primary outline, 8 points, counter clockwise
void_1 = [[22.5, 11.5], [40.5, 11.5], [40.5, 21.5], [22.5, 21.5]];  // pocket at grid node 0,0, 4 points
void_2 = [[22.5, 28.5], [40.5, 28.5], [40.5, 38.5], [22.5, 38.5]];  // pocket at grid node 0,1, 4 points
void_3 = [[69.5, 11.5], [87.5, 11.5], [87.5, 21.5], [69.5, 21.5]];  // pocket at grid node 1,0, 4 points
void_4 = [[69.5, 28.5], [87.5, 28.5], [87.5, 38.5], [69.5, 38.5]];  // pocket at grid node 1,1, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
  translate([0, 0, plate_t - depth_2])
    linear_extrude(height = depth_2 + 1) polygon(points = void_2);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_3);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_4);
}
