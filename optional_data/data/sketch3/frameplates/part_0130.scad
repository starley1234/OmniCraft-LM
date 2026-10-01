$fn = 32;

// ----------------------------------------------------------------------
// Frame plate: 90 x 70 frame, 14 mm rails
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 90;             // plate length, X
plate_w = 70;             // plate width, Y
plate_t = 8;              // plate thickness, Z (extrusion height)
corner_c = 5;             // corner chamfer
frame_bar = 14;           // frame rail width
bolt_r = 3.5;             // corner bolt window radius
bolt_inset = 7;           // bolt centre inset from the edges

win_l = plate_l - 2 * frame_bar;  // window length
win_w = plate_w - 2 * frame_bar;  // window width
bolt_d = 2 * bolt_r;  // corner hole diameter

profile = [[5, 0], [85, 0], [90, 5], [90, 65], [85, 70], [5, 70], [0, 65], [0, 5]];  // primary outline, 8 points, counter clockwise
void_1 = [[14, 14], [76, 14], [76, 56], [14, 56]];  // the window, 4 points
void_2 = [[10.234, 8.339], [8.339, 10.234], [5.661, 10.234], [3.766, 8.339], [3.766, 5.661], [5.661, 3.766], [8.339, 3.766], [10.234, 5.661]];  // corner bolt window, 8 points
void_3 = [[86.234, 8.339], [84.339, 10.234], [81.661, 10.234], [79.766, 8.339], [79.766, 5.661], [81.661, 3.766], [84.339, 3.766], [86.234, 5.661]];  // corner bolt window, 8 points
void_4 = [[10.234, 64.339], [8.339, 66.234], [5.661, 66.234], [3.766, 64.339], [3.766, 61.661], [5.661, 59.766], [8.339, 59.766], [10.234, 61.661]];  // corner bolt window, 8 points
void_5 = [[86.234, 64.339], [84.339, 66.234], [81.661, 66.234], [79.766, 64.339], [79.766, 61.661], [81.661, 59.766], [84.339, 59.766], [86.234, 61.661]];  // corner bolt window, 8 points

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
