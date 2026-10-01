$fn = 32;

// ----------------------------------------------------------------------
// Frame plate: 100 x 80 frame, 16 mm rails
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 100;            // plate length, X
plate_w = 80;             // plate width, Y
plate_t = 8;              // plate thickness, Z (extrusion height)
corner_c = 4;             // corner chamfer
frame_bar = 16;           // frame rail width
slot_l = 12;              // adjustment slot length
slot_w = 5;               // adjustment slot width

win_l = plate_l - 2 * frame_bar;  // window length
win_w = plate_w - 2 * frame_bar;  // window width

profile = [[4, 0], [96, 0], [100, 4], [100, 76], [96, 80], [4, 80], [0, 76], [0, 4]];  // primary outline, 8 points, counter clockwise
void_1 = [[16, 16], [84, 16], [84, 64], [16, 64]];  // the window, 4 points
void_2 = [[44, 5.5], [56, 5.5], [56, 10.5], [44, 10.5]];  // adjustment slot, 4 points
void_3 = [[44, 69.5], [56, 69.5], [56, 74.5], [44, 74.5]];  // adjustment slot, 4 points

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
