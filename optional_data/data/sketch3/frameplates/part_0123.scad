$fn = 32;

// ----------------------------------------------------------------------
// Frame plate: 100 x 70 frame, 16 mm rails
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 100;            // plate length, X
plate_w = 70;             // plate width, Y
plate_t = 6;              // plate thickness, Z (extrusion height)
corner_c = 4;             // corner chamfer
frame_bar = 16;           // frame rail width
bolt_r = 4;               // corner bolt window radius
bolt_inset = 8;           // bolt centre inset from the edges

win_l = plate_l - 2 * frame_bar;  // window length
win_w = plate_w - 2 * frame_bar;  // window width
bolt_d = 2 * bolt_r;  // corner hole diameter

profile = [[4, 0], [96, 0], [100, 4], [100, 66], [96, 70], [4, 70], [0, 66], [0, 4]];  // primary outline, 8 points, counter clockwise
void_1 = [[16, 16], [84, 16], [84, 54], [16, 54]];  // the window, 4 points
void_2 = [[11.696, 9.531], [9.531, 11.696], [6.469, 11.696], [4.304, 9.531], [4.304, 6.469], [6.469, 4.304], [9.531, 4.304], [11.696, 6.469]];  // corner bolt window, 8 points
void_3 = [[95.696, 9.531], [93.531, 11.696], [90.469, 11.696], [88.304, 9.531], [88.304, 6.469], [90.469, 4.304], [93.531, 4.304], [95.696, 6.469]];  // corner bolt window, 8 points
void_4 = [[11.696, 63.531], [9.531, 65.696], [6.469, 65.696], [4.304, 63.531], [4.304, 60.469], [6.469, 58.304], [9.531, 58.304], [11.696, 60.469]];  // corner bolt window, 8 points
void_5 = [[95.696, 63.531], [93.531, 65.696], [90.469, 65.696], [88.304, 63.531], [88.304, 60.469], [90.469, 58.304], [93.531, 58.304], [95.696, 60.469]];  // corner bolt window, 8 points

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
