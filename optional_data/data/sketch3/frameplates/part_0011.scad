$fn = 32;

// ----------------------------------------------------------------------
// Frame plate: 80 x 70 frame, 16 mm rails
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 80;             // plate length, X
plate_w = 70;             // plate width, Y
plate_t = 10;             // plate thickness, Z (extrusion height)
corner_c = 4;             // corner chamfer
frame_bar = 16;           // frame rail width
bolt_r = 3.5;             // corner bolt window radius
bolt_inset = 8;           // bolt centre inset from the edges

win_l = plate_l - 2 * frame_bar;  // window length
win_w = plate_w - 2 * frame_bar;  // window width
bolt_d = 2 * bolt_r;  // corner hole diameter

profile = [[4, 0], [76, 0], [80, 4], [80, 66], [76, 70], [4, 70], [0, 66], [0, 4]];  // primary outline, 8 points, counter clockwise
void_1 = [[16, 16], [64, 16], [64, 54], [16, 54]];  // the window, 4 points
void_2 = [[11.234, 9.339], [9.339, 11.234], [6.661, 11.234], [4.766, 9.339], [4.766, 6.661], [6.661, 4.766], [9.339, 4.766], [11.234, 6.661]];  // corner bolt window, 8 points
void_3 = [[75.234, 9.339], [73.339, 11.234], [70.661, 11.234], [68.766, 9.339], [68.766, 6.661], [70.661, 4.766], [73.339, 4.766], [75.234, 6.661]];  // corner bolt window, 8 points
void_4 = [[11.234, 63.339], [9.339, 65.234], [6.661, 65.234], [4.766, 63.339], [4.766, 60.661], [6.661, 58.766], [9.339, 58.766], [11.234, 60.661]];  // corner bolt window, 8 points
void_5 = [[75.234, 63.339], [73.339, 65.234], [70.661, 65.234], [68.766, 63.339], [68.766, 60.661], [70.661, 58.766], [73.339, 58.766], [75.234, 60.661]];  // corner bolt window, 8 points

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
