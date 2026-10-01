$fn = 32;

// ----------------------------------------------------------------------
// Frame plate: 110 x 60 frame, 12 mm rails
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 110;            // plate length, X
plate_w = 60;             // plate width, Y
plate_t = 8;              // plate thickness, Z (extrusion height)
corner_c = 4;             // corner chamfer
frame_bar = 12;           // frame rail width
bolt_r = 3.5;             // corner bolt window radius
bolt_inset = 6;           // bolt centre inset from the edges

win_l = plate_l - 2 * frame_bar;  // window length
win_w = plate_w - 2 * frame_bar;  // window width
bolt_d = 2 * bolt_r;  // corner hole diameter

profile = [[4, 0], [106, 0], [110, 4], [110, 56], [106, 60], [4, 60], [0, 56], [0, 4]];  // primary outline, 8 points, counter clockwise
void_1 = [[12, 12], [98, 12], [98, 48], [12, 48]];  // the window, 4 points
void_2 = [[9.234, 7.339], [7.339, 9.234], [4.661, 9.234], [2.766, 7.339], [2.766, 4.661], [4.661, 2.766], [7.339, 2.766], [9.234, 4.661]];  // corner bolt window, 8 points
void_3 = [[107.234, 7.339], [105.339, 9.234], [102.661, 9.234], [100.766, 7.339], [100.766, 4.661], [102.661, 2.766], [105.339, 2.766], [107.234, 4.661]];  // corner bolt window, 8 points
void_4 = [[9.234, 55.339], [7.339, 57.234], [4.661, 57.234], [2.766, 55.339], [2.766, 52.661], [4.661, 50.766], [7.339, 50.766], [9.234, 52.661]];  // corner bolt window, 8 points
void_5 = [[107.234, 55.339], [105.339, 57.234], [102.661, 57.234], [100.766, 55.339], [100.766, 52.661], [102.661, 50.766], [105.339, 50.766], [107.234, 52.661]];  // corner bolt window, 8 points

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
