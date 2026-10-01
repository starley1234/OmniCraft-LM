$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 4 voids, 120 x 60 x 8 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 120;            // plate length, X
plate_w = 60;             // plate width, Y
plate_t = 8;              // plate thickness, Z
edge_margin = 12;         // wall from the plate edge to any window
win_l = 18;               // pocket length
win_w = 12;               // pocket width
pitch_x = 48;             // grid pitch along X
pitch_y = 18;             // grid pitch along Y
depth_1 = 1.7;            // depth of void 1 (full thickness = through)
depth_2 = 8;              // depth of void 2 (full thickness = through)
depth_3 = 5.2;            // depth of void 3 (full thickness = through)
depth_4 = 8;              // depth of void 4 (full thickness = through)
corner_c = 3;             // corner chamfer of the plate

profile = [[3, 0], [117, 0], [120, 3], [120, 57], [117, 60], [3, 60], [0, 57], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[27, 15], [45, 15], [45, 27], [27, 27]];  // pocket at grid node 0,0, 4 points
void_2 = [[27, 33], [45, 33], [45, 45], [27, 45]];  // pocket at grid node 0,1, 4 points
void_3 = [[75, 15], [93, 15], [93, 27], [75, 27]];  // pocket at grid node 1,0, 4 points
void_4 = [[75, 33], [93, 33], [93, 45], [75, 45]];  // pocket at grid node 1,1, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_2);
  translate([0, 0, plate_t - depth_3])
    linear_extrude(height = depth_3 + 1) polygon(points = void_3);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_4);
}
