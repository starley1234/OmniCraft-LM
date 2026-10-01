$fn = 32;

// ----------------------------------------------------------------------
// Frame plate: 90 x 60 frame, 16 mm rails
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 90;             // plate length, X
plate_w = 60;             // plate width, Y
plate_t = 10;             // plate thickness, Z (extrusion height)
corner_c = 5;             // corner chamfer
frame_bar = 16;           // frame rail width
bolt_r = 3.5;             // corner bolt window radius
bolt_inset = 8;           // bolt centre inset from the edges

win_l = plate_l - 2 * frame_bar;  // window length
win_w = plate_w - 2 * frame_bar;  // window width
bolt_d = 2 * bolt_r;  // corner hole diameter

profile = [[5, 0], [85, 0], [90, 5], [90, 55], [85, 60], [5, 60], [0, 55], [0, 5]];  // primary outline, 8 points, counter clockwise
void_1 = [[16, 16], [74, 16], [74, 44], [16, 44]];  // the window, 4 points
void_2 = [[11.234, 9.339], [9.339, 11.234], [6.661, 11.234], [4.766, 9.339], [4.766, 6.661], [6.661, 4.766], [9.339, 4.766], [11.234, 6.661]];  // corner bolt window, 8 points
void_3 = [[85.234, 9.339], [83.339, 11.234], [80.661, 11.234], [78.766, 9.339], [78.766, 6.661], [80.661, 4.766], [83.339, 4.766], [85.234, 6.661]];  // corner bolt window, 8 points
void_4 = [[11.234, 53.339], [9.339, 55.234], [6.661, 55.234], [4.766, 53.339], [4.766, 50.661], [6.661, 48.766], [9.339, 48.766], [11.234, 50.661]];  // corner bolt window, 8 points
void_5 = [[85.234, 53.339], [83.339, 55.234], [80.661, 55.234], [78.766, 53.339], [78.766, 50.661], [80.661, 48.766], [83.339, 48.766], [85.234, 50.661]];  // corner bolt window, 8 points

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
