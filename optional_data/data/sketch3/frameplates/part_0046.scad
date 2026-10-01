$fn = 32;

// ----------------------------------------------------------------------
// Frame plate: 80 x 70 frame, 12 mm rails
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 80;             // plate length, X
plate_w = 70;             // plate width, Y
plate_t = 6;              // plate thickness, Z (extrusion height)
corner_c = 4;             // corner chamfer
frame_bar = 12;           // frame rail width
bolt_r = 4;               // corner bolt window radius
bolt_inset = 6;           // bolt centre inset from the edges

win_l = plate_l - 2 * frame_bar;  // window length
win_w = plate_w - 2 * frame_bar;  // window width
bolt_d = 2 * bolt_r;  // corner hole diameter

profile = [[4, 0], [76, 0], [80, 4], [80, 66], [76, 70], [4, 70], [0, 66], [0, 4]];  // primary outline, 8 points, counter clockwise
void_1 = [[12, 12], [68, 12], [68, 58], [12, 58]];  // the window, 4 points
void_2 = [[9.696, 7.531], [7.531, 9.696], [4.469, 9.696], [2.304, 7.531], [2.304, 4.469], [4.469, 2.304], [7.531, 2.304], [9.696, 4.469]];  // corner bolt window, 8 points
void_3 = [[77.696, 7.531], [75.531, 9.696], [72.469, 9.696], [70.304, 7.531], [70.304, 4.469], [72.469, 2.304], [75.531, 2.304], [77.696, 4.469]];  // corner bolt window, 8 points
void_4 = [[9.696, 65.531], [7.531, 67.696], [4.469, 67.696], [2.304, 65.531], [2.304, 62.469], [4.469, 60.304], [7.531, 60.304], [9.696, 62.469]];  // corner bolt window, 8 points
void_5 = [[77.696, 65.531], [75.531, 67.696], [72.469, 67.696], [70.304, 65.531], [70.304, 62.469], [72.469, 60.304], [75.531, 60.304], [77.696, 62.469]];  // corner bolt window, 8 points

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
