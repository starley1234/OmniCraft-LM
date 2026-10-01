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
bolt_r = 3;               // corner bolt window radius
bolt_inset = 7;           // bolt centre inset from the edges

win_l = plate_l - 2 * frame_bar;  // window length
win_w = plate_w - 2 * frame_bar;  // window width
bolt_d = 2 * bolt_r;  // corner hole diameter

profile = [[5, 0], [85, 0], [90, 5], [90, 65], [85, 70], [5, 70], [0, 65], [0, 5]];  // primary outline, 8 points, counter clockwise
void_1 = [[14, 14], [76, 14], [76, 56], [14, 56]];  // the window, 4 points
void_2 = [[9.772, 8.148], [8.148, 9.772], [5.852, 9.772], [4.228, 8.148], [4.228, 5.852], [5.852, 4.228], [8.148, 4.228], [9.772, 5.852]];  // corner bolt window, 8 points
void_3 = [[85.772, 8.148], [84.148, 9.772], [81.852, 9.772], [80.228, 8.148], [80.228, 5.852], [81.852, 4.228], [84.148, 4.228], [85.772, 5.852]];  // corner bolt window, 8 points
void_4 = [[9.772, 64.148], [8.148, 65.772], [5.852, 65.772], [4.228, 64.148], [4.228, 61.852], [5.852, 60.228], [8.148, 60.228], [9.772, 61.852]];  // corner bolt window, 8 points
void_5 = [[85.772, 64.148], [84.148, 65.772], [81.852, 65.772], [80.228, 64.148], [80.228, 61.852], [81.852, 60.228], [84.148, 60.228], [85.772, 61.852]];  // corner bolt window, 8 points

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
