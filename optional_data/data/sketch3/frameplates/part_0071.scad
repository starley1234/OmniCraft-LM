$fn = 32;

// ----------------------------------------------------------------------
// Frame plate: 90 x 80 frame, 12 mm rails
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 90;             // plate length, X
plate_w = 80;             // plate width, Y
plate_t = 10;             // plate thickness, Z (extrusion height)
corner_c = 5;             // corner chamfer
frame_bar = 12;           // frame rail width
bolt_r = 4;               // corner bolt window radius
bolt_inset = 6;           // bolt centre inset from the edges

win_l = plate_l - 2 * frame_bar;  // window length
win_w = plate_w - 2 * frame_bar;  // window width
bolt_d = 2 * bolt_r;  // corner hole diameter

profile = [[5, 0], [85, 0], [90, 5], [90, 75], [85, 80], [5, 80], [0, 75], [0, 5]];  // primary outline, 8 points, counter clockwise
void_1 = [[12, 12], [78, 12], [78, 68], [12, 68]];  // the window, 4 points
void_2 = [[9.696, 7.531], [7.531, 9.696], [4.469, 9.696], [2.304, 7.531], [2.304, 4.469], [4.469, 2.304], [7.531, 2.304], [9.696, 4.469]];  // corner bolt window, 8 points
void_3 = [[87.696, 7.531], [85.531, 9.696], [82.469, 9.696], [80.304, 7.531], [80.304, 4.469], [82.469, 2.304], [85.531, 2.304], [87.696, 4.469]];  // corner bolt window, 8 points
void_4 = [[9.696, 75.531], [7.531, 77.696], [4.469, 77.696], [2.304, 75.531], [2.304, 72.469], [4.469, 70.304], [7.531, 70.304], [9.696, 72.469]];  // corner bolt window, 8 points
void_5 = [[87.696, 75.531], [85.531, 77.696], [82.469, 77.696], [80.304, 75.531], [80.304, 72.469], [82.469, 70.304], [85.531, 70.304], [87.696, 72.469]];  // corner bolt window, 8 points

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
