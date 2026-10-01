$fn = 32;

// ----------------------------------------------------------------------
// Frame plate: 90 x 80 frame, 14 mm rails
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 90;             // plate length, X
plate_w = 80;             // plate width, Y
plate_t = 8;              // plate thickness, Z (extrusion height)
corner_c = 5;             // corner chamfer
frame_bar = 14;           // frame rail width
bolt_r = 4;               // corner bolt window radius
bolt_inset = 7;           // bolt centre inset from the edges

win_l = plate_l - 2 * frame_bar;  // window length
win_w = plate_w - 2 * frame_bar;  // window width
bolt_d = 2 * bolt_r;  // corner hole diameter

profile = [[5, 0], [85, 0], [90, 5], [90, 75], [85, 80], [5, 80], [0, 75], [0, 5]];  // primary outline, 8 points, counter clockwise
void_1 = [[14, 14], [76, 14], [76, 66], [14, 66]];  // the window, 4 points
void_2 = [[10.696, 8.531], [8.531, 10.696], [5.469, 10.696], [3.304, 8.531], [3.304, 5.469], [5.469, 3.304], [8.531, 3.304], [10.696, 5.469]];  // corner bolt window, 8 points
void_3 = [[86.696, 8.531], [84.531, 10.696], [81.469, 10.696], [79.304, 8.531], [79.304, 5.469], [81.469, 3.304], [84.531, 3.304], [86.696, 5.469]];  // corner bolt window, 8 points
void_4 = [[10.696, 74.531], [8.531, 76.696], [5.469, 76.696], [3.304, 74.531], [3.304, 71.469], [5.469, 69.304], [8.531, 69.304], [10.696, 71.469]];  // corner bolt window, 8 points
void_5 = [[86.696, 74.531], [84.531, 76.696], [81.469, 76.696], [79.304, 74.531], [79.304, 71.469], [81.469, 69.304], [84.531, 69.304], [86.696, 71.469]];  // corner bolt window, 8 points

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
