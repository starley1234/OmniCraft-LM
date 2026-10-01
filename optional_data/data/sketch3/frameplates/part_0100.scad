$fn = 32;

// ----------------------------------------------------------------------
// Frame plate: 90 x 80 frame, 14 mm rails
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 90;             // plate length, X
plate_w = 80;             // plate width, Y
plate_t = 10;             // plate thickness, Z (extrusion height)
corner_c = 4;             // corner chamfer
frame_bar = 14;           // frame rail width
slot_l = 10;              // adjustment slot length
slot_w = 5;               // adjustment slot width
fit_tol = 0.02;           // declared fit tolerance (prompt contract)
free_tol = 0.2;           // declared free tolerance (prompt contract)

win_l = plate_l - 2 * frame_bar;  // window length
win_w = plate_w - 2 * frame_bar;  // window width

profile = [[4, 0], [86, 0], [90, 4], [90, 76], [86, 80], [4, 80], [0, 76], [0, 4]];  // primary outline, 8 points, counter clockwise
void_1 = [[14, 14], [76, 14], [76, 66], [14, 66]];  // the window, 4 points
void_2 = [[40, 4.5], [50, 4.5], [50, 9.5], [40, 9.5]];  // adjustment slot, 4 points
void_3 = [[40, 70.5], [50, 70.5], [50, 75.5], [40, 75.5]];  // adjustment slot, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_2);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_3);
}
