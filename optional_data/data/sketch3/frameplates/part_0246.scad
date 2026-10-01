$fn = 32;

// ----------------------------------------------------------------------
// Frame plate: 120 x 60 frame, 16 mm rails
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 120;            // plate length, X
plate_w = 60;             // plate width, Y
plate_t = 6;              // plate thickness, Z (extrusion height)
corner_c = 4;             // corner chamfer
frame_bar = 16;           // frame rail width
bolt_r = 4;               // corner bolt window radius
bolt_inset = 8;           // bolt centre inset from the edges

win_l = plate_l - 2 * frame_bar;  // window length
win_w = plate_w - 2 * frame_bar;  // window width
bolt_d = 2 * bolt_r;  // corner hole diameter

profile = [[4, 0], [116, 0], [120, 4], [120, 56], [116, 60], [4, 60], [0, 56], [0, 4]];  // primary outline, 8 points, counter clockwise
void_1 = [[16, 16], [104, 16], [104, 44], [16, 44]];  // the window, 4 points
void_2 = [[11.696, 9.531], [9.531, 11.696], [6.469, 11.696], [4.304, 9.531], [4.304, 6.469], [6.469, 4.304], [9.531, 4.304], [11.696, 6.469]];  // corner bolt window, 8 points
void_3 = [[115.696, 9.531], [113.531, 11.696], [110.469, 11.696], [108.304, 9.531], [108.304, 6.469], [110.469, 4.304], [113.531, 4.304], [115.696, 6.469]];  // corner bolt window, 8 points
void_4 = [[11.696, 53.531], [9.531, 55.696], [6.469, 55.696], [4.304, 53.531], [4.304, 50.469], [6.469, 48.304], [9.531, 48.304], [11.696, 50.469]];  // corner bolt window, 8 points
void_5 = [[115.696, 53.531], [113.531, 55.696], [110.469, 55.696], [108.304, 53.531], [108.304, 50.469], [110.469, 48.304], [113.531, 48.304], [115.696, 50.469]];  // corner bolt window, 8 points

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
