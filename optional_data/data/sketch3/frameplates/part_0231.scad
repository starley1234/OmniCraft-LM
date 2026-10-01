$fn = 32;

// ----------------------------------------------------------------------
// Frame plate: 100 x 60 frame, 14 mm rails
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 100;            // plate length, X
plate_w = 60;             // plate width, Y
plate_t = 10;             // plate thickness, Z (extrusion height)
corner_c = 5;             // corner chamfer
frame_bar = 14;           // frame rail width
slot_l = 10;              // adjustment slot length
slot_w = 4;               // adjustment slot width

win_l = plate_l - 2 * frame_bar;  // window length
win_w = plate_w - 2 * frame_bar;  // window width

profile = [[5, 0], [95, 0], [100, 5], [100, 55], [95, 60], [5, 60], [0, 55], [0, 5]];  // primary outline, 8 points, counter clockwise
void_1 = [[14, 14], [86, 14], [86, 46], [14, 46]];  // the window, 4 points
void_2 = [[45, 5], [55, 5], [55, 9], [45, 9]];  // adjustment slot, 4 points
void_3 = [[45, 51], [55, 51], [55, 55], [45, 55]];  // adjustment slot, 4 points

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
