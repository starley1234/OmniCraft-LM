$fn = 32;

// ----------------------------------------------------------------------
// Frame plate: 100 x 70 frame, 12 mm rails
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 100;            // plate length, X
plate_w = 70;             // plate width, Y
plate_t = 10;             // plate thickness, Z (extrusion height)
corner_c = 4;             // corner chamfer
frame_bar = 12;           // frame rail width
bolt_r = 4;               // corner bolt window radius
bolt_inset = 6;           // bolt centre inset from the edges

win_l = plate_l - 2 * frame_bar;  // window length
win_w = plate_w - 2 * frame_bar;  // window width
bolt_d = 2 * bolt_r;  // corner hole diameter

profile = [[4, 0], [96, 0], [100, 4], [100, 66], [96, 70], [4, 70], [0, 66], [0, 4]];  // primary outline, 8 points, counter clockwise
void_1 = [[12, 12], [88, 12], [88, 58], [12, 58]];  // the window, 4 points
void_2 = [[9.696, 7.531], [7.531, 9.696], [4.469, 9.696], [2.304, 7.531], [2.304, 4.469], [4.469, 2.304], [7.531, 2.304], [9.696, 4.469]];  // corner bolt window, 8 points
void_3 = [[97.696, 7.531], [95.531, 9.696], [92.469, 9.696], [90.304, 7.531], [90.304, 4.469], [92.469, 2.304], [95.531, 2.304], [97.696, 4.469]];  // corner bolt window, 8 points
void_4 = [[9.696, 65.531], [7.531, 67.696], [4.469, 67.696], [2.304, 65.531], [2.304, 62.469], [4.469, 60.304], [7.531, 60.304], [9.696, 62.469]];  // corner bolt window, 8 points
void_5 = [[97.696, 65.531], [95.531, 67.696], [92.469, 67.696], [90.304, 65.531], [90.304, 62.469], [92.469, 60.304], [95.531, 60.304], [97.696, 62.469]];  // corner bolt window, 8 points

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
