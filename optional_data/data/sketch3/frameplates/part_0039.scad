$fn = 32;

// ----------------------------------------------------------------------
// Frame plate: 120 x 60 frame, 14 mm rails
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 120;            // plate length, X
plate_w = 60;             // plate width, Y
plate_t = 10;             // plate thickness, Z (extrusion height)
corner_c = 4;             // corner chamfer
frame_bar = 14;           // frame rail width
bolt_r = 3;               // corner bolt window radius
bolt_inset = 7;           // bolt centre inset from the edges

win_l = plate_l - 2 * frame_bar;  // window length
win_w = plate_w - 2 * frame_bar;  // window width
bolt_d = 2 * bolt_r;  // corner hole diameter

profile = [[4, 0], [116, 0], [120, 4], [120, 56], [116, 60], [4, 60], [0, 56], [0, 4]];  // primary outline, 8 points, counter clockwise
void_1 = [[14, 14], [106, 14], [106, 46], [14, 46]];  // the window, 4 points
void_2 = [[9.772, 8.148], [8.148, 9.772], [5.852, 9.772], [4.228, 8.148], [4.228, 5.852], [5.852, 4.228], [8.148, 4.228], [9.772, 5.852]];  // corner bolt window, 8 points
void_3 = [[115.772, 8.148], [114.148, 9.772], [111.852, 9.772], [110.228, 8.148], [110.228, 5.852], [111.852, 4.228], [114.148, 4.228], [115.772, 5.852]];  // corner bolt window, 8 points
void_4 = [[9.772, 54.148], [8.148, 55.772], [5.852, 55.772], [4.228, 54.148], [4.228, 51.852], [5.852, 50.228], [8.148, 50.228], [9.772, 51.852]];  // corner bolt window, 8 points
void_5 = [[115.772, 54.148], [114.148, 55.772], [111.852, 55.772], [110.228, 54.148], [110.228, 51.852], [111.852, 50.228], [114.148, 50.228], [115.772, 51.852]];  // corner bolt window, 8 points

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
