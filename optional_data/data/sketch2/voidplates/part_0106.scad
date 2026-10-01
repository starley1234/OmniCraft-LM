$fn = 32;

// ----------------------------------------------------------------------
// Windowed plate: 3 voids, 90 x 60 x 5 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 90;             // plate length, X
plate_w = 60;             // plate width, Y
plate_t = 5;              // plate thickness, Z
edge_margin = 10;         // wall from the plate edge to any window
windows = 3;              // number of windows in the row
win_l = 18;               // window length
win_w = 14;               // window width
win_pitch = 23.3;         // window pitch along X
depth_1 = 2.8;            // depth of void 1 (full thickness = through)
depth_2 = 3.2;            // depth of void 2 (full thickness = through)
depth_3 = 1.8;            // depth of void 3 (full thickness = through)
corner_c = 5;             // corner chamfer of the plate

profile = [[5, 0], [85, 0], [90, 5], [90, 55], [85, 60], [5, 60], [0, 55], [0, 5]];  // primary outline, 8 points, counter clockwise
void_1 = [[12.65, 23], [30.65, 23], [30.65, 37], [12.65, 37]];  // window 1 of the row, 4 points
void_2 = [[35.95, 23], [53.95, 23], [53.95, 37], [35.95, 37]];  // window 2 of the row, 4 points
void_3 = [[59.25, 23], [77.25, 23], [77.25, 37], [59.25, 37]];  // window 3 of the row, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, plate_t - depth_1])
    linear_extrude(height = depth_1 + 1) polygon(points = void_1);
  translate([0, 0, plate_t - depth_2])
    linear_extrude(height = depth_2 + 1) polygon(points = void_2);
  translate([0, 0, plate_t - depth_3])
    linear_extrude(height = depth_3 + 1) polygon(points = void_3);
}
