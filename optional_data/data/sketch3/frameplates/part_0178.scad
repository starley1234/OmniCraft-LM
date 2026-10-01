$fn = 32;

// ----------------------------------------------------------------------
// Frame plate: 80 x 80 frame, 16 mm rails
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 80;             // plate length, X
plate_w = 80;             // plate width, Y
plate_t = 8;              // plate thickness, Z (extrusion height)
corner_c = 3;             // corner chamfer
frame_bar = 16;           // frame rail width
bolt_r = 3.5;             // corner bolt window radius
bolt_inset = 8;           // bolt centre inset from the edges

win_l = plate_l - 2 * frame_bar;  // window length
win_w = plate_w - 2 * frame_bar;  // window width
bolt_d = 2 * bolt_r;  // corner hole diameter

profile = [[3, 0], [77, 0], [80, 3], [80, 77], [77, 80], [3, 80], [0, 77], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[16, 16], [64, 16], [64, 64], [16, 64]];  // the window, 4 points
void_2 = [[11.234, 9.339], [9.339, 11.234], [6.661, 11.234], [4.766, 9.339], [4.766, 6.661], [6.661, 4.766], [9.339, 4.766], [11.234, 6.661]];  // corner bolt window, 8 points
void_3 = [[75.234, 9.339], [73.339, 11.234], [70.661, 11.234], [68.766, 9.339], [68.766, 6.661], [70.661, 4.766], [73.339, 4.766], [75.234, 6.661]];  // corner bolt window, 8 points
void_4 = [[11.234, 73.339], [9.339, 75.234], [6.661, 75.234], [4.766, 73.339], [4.766, 70.661], [6.661, 68.766], [9.339, 68.766], [11.234, 70.661]];  // corner bolt window, 8 points
void_5 = [[75.234, 73.339], [73.339, 75.234], [70.661, 75.234], [68.766, 73.339], [68.766, 70.661], [70.661, 68.766], [73.339, 68.766], [75.234, 70.661]];  // corner bolt window, 8 points

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
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_5);
}
