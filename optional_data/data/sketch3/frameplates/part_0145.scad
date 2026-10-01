$fn = 32;

// ----------------------------------------------------------------------
// Frame plate: 120 x 60 frame, 14 mm rails
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 120;            // plate length, X
plate_w = 60;             // plate width, Y
plate_t = 6;              // plate thickness, Z (extrusion height)
corner_c = 5;             // corner chamfer
frame_bar = 14;           // frame rail width
bolt_r = 4;               // corner bolt window radius
bolt_inset = 7;           // bolt centre inset from the edges

win_l = plate_l - 2 * frame_bar;  // window length
win_w = plate_w - 2 * frame_bar;  // window width
bolt_d = 2 * bolt_r;  // corner hole diameter

profile = [[5, 0], [115, 0], [120, 5], [120, 55], [115, 60], [5, 60], [0, 55], [0, 5]];  // primary outline, 8 points, counter clockwise
void_1 = [[14, 14], [106, 14], [106, 46], [14, 46]];  // the window, 4 points
void_2 = [[10.696, 8.531], [8.531, 10.696], [5.469, 10.696], [3.304, 8.531], [3.304, 5.469], [5.469, 3.304], [8.531, 3.304], [10.696, 5.469]];  // corner bolt window, 8 points
void_3 = [[116.696, 8.531], [114.531, 10.696], [111.469, 10.696], [109.304, 8.531], [109.304, 5.469], [111.469, 3.304], [114.531, 3.304], [116.696, 5.469]];  // corner bolt window, 8 points
void_4 = [[10.696, 54.531], [8.531, 56.696], [5.469, 56.696], [3.304, 54.531], [3.304, 51.469], [5.469, 49.304], [8.531, 49.304], [10.696, 51.469]];  // corner bolt window, 8 points
void_5 = [[116.696, 54.531], [114.531, 56.696], [111.469, 56.696], [109.304, 54.531], [109.304, 51.469], [111.469, 49.304], [114.531, 49.304], [116.696, 51.469]];  // corner bolt window, 8 points

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
