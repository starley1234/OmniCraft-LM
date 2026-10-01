$fn = 32;

// ----------------------------------------------------------------------
// Frame plate: 100 x 80 frame, 14 mm rails
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 100;            // plate length, X
plate_w = 80;             // plate width, Y
plate_t = 6;              // plate thickness, Z (extrusion height)
corner_c = 4;             // corner chamfer
frame_bar = 14;           // frame rail width
bolt_r = 3.5;             // corner bolt window radius
bolt_inset = 7;           // bolt centre inset from the edges

win_l = plate_l - 2 * frame_bar;  // window length
win_w = plate_w - 2 * frame_bar;  // window width
bolt_d = 2 * bolt_r;  // corner hole diameter

profile = [[4, 0], [96, 0], [100, 4], [100, 76], [96, 80], [4, 80], [0, 76], [0, 4]];  // primary outline, 8 points, counter clockwise
void_1 = [[14, 14], [86, 14], [86, 66], [14, 66]];  // the window, 4 points
void_2 = [[10.234, 8.339], [8.339, 10.234], [5.661, 10.234], [3.766, 8.339], [3.766, 5.661], [5.661, 3.766], [8.339, 3.766], [10.234, 5.661]];  // corner bolt window, 8 points
void_3 = [[96.234, 8.339], [94.339, 10.234], [91.661, 10.234], [89.766, 8.339], [89.766, 5.661], [91.661, 3.766], [94.339, 3.766], [96.234, 5.661]];  // corner bolt window, 8 points
void_4 = [[10.234, 74.339], [8.339, 76.234], [5.661, 76.234], [3.766, 74.339], [3.766, 71.661], [5.661, 69.766], [8.339, 69.766], [10.234, 71.661]];  // corner bolt window, 8 points
void_5 = [[96.234, 74.339], [94.339, 76.234], [91.661, 76.234], [89.766, 74.339], [89.766, 71.661], [91.661, 69.766], [94.339, 69.766], [96.234, 71.661]];  // corner bolt window, 8 points

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
