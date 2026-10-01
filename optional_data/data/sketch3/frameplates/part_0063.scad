$fn = 32;

// ----------------------------------------------------------------------
// Frame plate: 90 x 80 frame, 16 mm rails
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 90;             // plate length, X
plate_w = 80;             // plate width, Y
plate_t = 6;              // plate thickness, Z (extrusion height)
corner_c = 3;             // corner chamfer
frame_bar = 16;           // frame rail width
bolt_r = 4;               // corner bolt window radius
bolt_inset = 8;           // bolt centre inset from the edges

win_l = plate_l - 2 * frame_bar;  // window length
win_w = plate_w - 2 * frame_bar;  // window width
bolt_d = 2 * bolt_r;  // corner hole diameter

profile = [[3, 0], [87, 0], [90, 3], [90, 77], [87, 80], [3, 80], [0, 77], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[16, 16], [74, 16], [74, 64], [16, 64]];  // the window, 4 points
void_2 = [[11.696, 9.531], [9.531, 11.696], [6.469, 11.696], [4.304, 9.531], [4.304, 6.469], [6.469, 4.304], [9.531, 4.304], [11.696, 6.469]];  // corner bolt window, 8 points
void_3 = [[85.696, 9.531], [83.531, 11.696], [80.469, 11.696], [78.304, 9.531], [78.304, 6.469], [80.469, 4.304], [83.531, 4.304], [85.696, 6.469]];  // corner bolt window, 8 points
void_4 = [[11.696, 73.531], [9.531, 75.696], [6.469, 75.696], [4.304, 73.531], [4.304, 70.469], [6.469, 68.304], [9.531, 68.304], [11.696, 70.469]];  // corner bolt window, 8 points
void_5 = [[85.696, 73.531], [83.531, 75.696], [80.469, 75.696], [78.304, 73.531], [78.304, 70.469], [80.469, 68.304], [83.531, 68.304], [85.696, 70.469]];  // corner bolt window, 8 points

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
