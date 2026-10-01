$fn = 32;

// ----------------------------------------------------------------------
// Frame plate: 110 x 70 frame, 12 mm rails
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 110;            // plate length, X
plate_w = 70;             // plate width, Y
plate_t = 8;              // plate thickness, Z (extrusion height)
corner_c = 5;             // corner chamfer
frame_bar = 12;           // frame rail width
slot_l = 8;               // adjustment slot length
slot_w = 4;               // adjustment slot width

win_l = plate_l - 2 * frame_bar;  // window length
win_w = plate_w - 2 * frame_bar;  // window width

profile = [[5, 0], [105, 0], [110, 5], [110, 65], [105, 70], [5, 70], [0, 65], [0, 5]];  // primary outline, 8 points, counter clockwise
void_1 = [[12, 12], [98, 12], [98, 58], [12, 58]];  // the window, 4 points
void_2 = [[51, 4], [59, 4], [59, 8], [51, 8]];  // adjustment slot, 4 points
void_3 = [[51, 62], [59, 62], [59, 66], [51, 66]];  // adjustment slot, 4 points

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
