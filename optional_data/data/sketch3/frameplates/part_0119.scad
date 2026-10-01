$fn = 32;

// ----------------------------------------------------------------------
// Frame plate: 100 x 80 frame, 14 mm rails
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 100;            // plate length, X
plate_w = 80;             // plate width, Y
plate_t = 6;              // plate thickness, Z (extrusion height)
corner_c = 3;             // corner chamfer
frame_bar = 14;           // frame rail width
slot_l = 10;              // adjustment slot length
slot_w = 5;               // adjustment slot width

win_l = plate_l - 2 * frame_bar;  // window length
win_w = plate_w - 2 * frame_bar;  // window width

profile = [[3, 0], [97, 0], [100, 3], [100, 77], [97, 80], [3, 80], [0, 77], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[14, 14], [86, 14], [86, 66], [14, 66]];  // the window, 4 points
void_2 = [[45, 4.5], [55, 4.5], [55, 9.5], [45, 9.5]];  // adjustment slot, 4 points
void_3 = [[45, 70.5], [55, 70.5], [55, 75.5], [45, 75.5]];  // adjustment slot, 4 points

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
