$fn = 32;

// ----------------------------------------------------------------------
// Frame plate: 120 x 60 frame, 16 mm rails
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 120;            // plate length, X
plate_w = 60;             // plate width, Y
plate_t = 6;              // plate thickness, Z (extrusion height)
corner_c = 3;             // corner chamfer
frame_bar = 16;           // frame rail width
slot_l = 12;              // adjustment slot length
slot_w = 5;               // adjustment slot width

win_l = plate_l - 2 * frame_bar;  // window length
win_w = plate_w - 2 * frame_bar;  // window width

profile = [[3, 0], [117, 0], [120, 3], [120, 57], [117, 60], [3, 60], [0, 57], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[16, 16], [104, 16], [104, 44], [16, 44]];  // the window, 4 points
void_2 = [[54, 5.5], [66, 5.5], [66, 10.5], [54, 10.5]];  // adjustment slot, 4 points
void_3 = [[54, 49.5], [66, 49.5], [66, 54.5], [54, 54.5]];  // adjustment slot, 4 points

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
