$fn = 32;

// ----------------------------------------------------------------------
// Frame plate: 120 x 70 frame, 12 mm rails
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 120;            // plate length, X
plate_w = 70;             // plate width, Y
plate_t = 8;              // plate thickness, Z (extrusion height)
corner_c = 5;             // corner chamfer
frame_bar = 12;           // frame rail width
bolt_r = 3.5;             // corner bolt window radius
bolt_inset = 6;           // bolt centre inset from the edges

win_l = plate_l - 2 * frame_bar;  // window length
win_w = plate_w - 2 * frame_bar;  // window width
bolt_d = 2 * bolt_r;  // corner hole diameter

profile = [[5, 0], [115, 0], [120, 5], [120, 65], [115, 70], [5, 70], [0, 65], [0, 5]];  // primary outline, 8 points, counter clockwise
void_1 = [[12, 12], [108, 12], [108, 58], [12, 58]];  // the window, 4 points
void_2 = [[9.234, 7.339], [7.339, 9.234], [4.661, 9.234], [2.766, 7.339], [2.766, 4.661], [4.661, 2.766], [7.339, 2.766], [9.234, 4.661]];  // corner bolt window, 8 points
void_3 = [[117.234, 7.339], [115.339, 9.234], [112.661, 9.234], [110.766, 7.339], [110.766, 4.661], [112.661, 2.766], [115.339, 2.766], [117.234, 4.661]];  // corner bolt window, 8 points
void_4 = [[9.234, 65.339], [7.339, 67.234], [4.661, 67.234], [2.766, 65.339], [2.766, 62.661], [4.661, 60.766], [7.339, 60.766], [9.234, 62.661]];  // corner bolt window, 8 points
void_5 = [[117.234, 65.339], [115.339, 67.234], [112.661, 67.234], [110.766, 65.339], [110.766, 62.661], [112.661, 60.766], [115.339, 60.766], [117.234, 62.661]];  // corner bolt window, 8 points

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
