$fn = 32;

// ----------------------------------------------------------------------
// Frame plate: 120 x 80 frame, 14 mm rails
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 120;            // plate length, X
plate_w = 80;             // plate width, Y
plate_t = 8;              // plate thickness, Z (extrusion height)
corner_c = 3;             // corner chamfer
frame_bar = 14;           // frame rail width
bolt_r = 3.5;             // corner bolt window radius
bolt_inset = 7;           // bolt centre inset from the edges

win_l = plate_l - 2 * frame_bar;  // window length
win_w = plate_w - 2 * frame_bar;  // window width
bolt_d = 2 * bolt_r;  // corner hole diameter

profile = [[3, 0], [117, 0], [120, 3], [120, 77], [117, 80], [3, 80], [0, 77], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[14, 14], [106, 14], [106, 66], [14, 66]];  // the window, 4 points
void_2 = [[10.234, 8.339], [8.339, 10.234], [5.661, 10.234], [3.766, 8.339], [3.766, 5.661], [5.661, 3.766], [8.339, 3.766], [10.234, 5.661]];  // corner bolt window, 8 points
void_3 = [[116.234, 8.339], [114.339, 10.234], [111.661, 10.234], [109.766, 8.339], [109.766, 5.661], [111.661, 3.766], [114.339, 3.766], [116.234, 5.661]];  // corner bolt window, 8 points
void_4 = [[10.234, 74.339], [8.339, 76.234], [5.661, 76.234], [3.766, 74.339], [3.766, 71.661], [5.661, 69.766], [8.339, 69.766], [10.234, 71.661]];  // corner bolt window, 8 points
void_5 = [[116.234, 74.339], [114.339, 76.234], [111.661, 76.234], [109.766, 74.339], [109.766, 71.661], [111.661, 69.766], [114.339, 69.766], [116.234, 71.661]];  // corner bolt window, 8 points

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
