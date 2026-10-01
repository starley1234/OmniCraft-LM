$fn = 32;

// ----------------------------------------------------------------------
// Frame plate: 120 x 60 frame, 12 mm rails
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 120;            // plate length, X
plate_w = 60;             // plate width, Y
plate_t = 10;             // plate thickness, Z (extrusion height)
corner_c = 3;             // corner chamfer
frame_bar = 12;           // frame rail width
bolt_r = 4;               // corner bolt window radius
bolt_inset = 6;           // bolt centre inset from the edges

win_l = plate_l - 2 * frame_bar;  // window length
win_w = plate_w - 2 * frame_bar;  // window width
bolt_d = 2 * bolt_r;  // corner hole diameter

profile = [[3, 0], [117, 0], [120, 3], [120, 57], [117, 60], [3, 60], [0, 57], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[12, 12], [108, 12], [108, 48], [12, 48]];  // the window, 4 points
void_2 = [[9.696, 7.531], [7.531, 9.696], [4.469, 9.696], [2.304, 7.531], [2.304, 4.469], [4.469, 2.304], [7.531, 2.304], [9.696, 4.469]];  // corner bolt window, 8 points
void_3 = [[117.696, 7.531], [115.531, 9.696], [112.469, 9.696], [110.304, 7.531], [110.304, 4.469], [112.469, 2.304], [115.531, 2.304], [117.696, 4.469]];  // corner bolt window, 8 points
void_4 = [[9.696, 55.531], [7.531, 57.696], [4.469, 57.696], [2.304, 55.531], [2.304, 52.469], [4.469, 50.304], [7.531, 50.304], [9.696, 52.469]];  // corner bolt window, 8 points
void_5 = [[117.696, 55.531], [115.531, 57.696], [112.469, 57.696], [110.304, 55.531], [110.304, 52.469], [112.469, 50.304], [115.531, 50.304], [117.696, 52.469]];  // corner bolt window, 8 points

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
