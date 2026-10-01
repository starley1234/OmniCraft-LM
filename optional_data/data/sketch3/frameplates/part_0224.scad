$fn = 32;

// ----------------------------------------------------------------------
// Frame plate: 120 x 80 frame, 14 mm rails
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 120;            // plate length, X
plate_w = 80;             // plate width, Y
plate_t = 6;              // plate thickness, Z (extrusion height)
corner_c = 5;             // corner chamfer
frame_bar = 14;           // frame rail width
bolt_r = 3;               // corner bolt window radius
bolt_inset = 7;           // bolt centre inset from the edges

win_l = plate_l - 2 * frame_bar;  // window length
win_w = plate_w - 2 * frame_bar;  // window width
bolt_d = 2 * bolt_r;  // corner hole diameter

profile = [[5, 0], [115, 0], [120, 5], [120, 75], [115, 80], [5, 80], [0, 75], [0, 5]];  // primary outline, 8 points, counter clockwise
void_1 = [[14, 14], [106, 14], [106, 66], [14, 66]];  // the window, 4 points
void_2 = [[9.772, 8.148], [8.148, 9.772], [5.852, 9.772], [4.228, 8.148], [4.228, 5.852], [5.852, 4.228], [8.148, 4.228], [9.772, 5.852]];  // corner bolt window, 8 points
void_3 = [[115.772, 8.148], [114.148, 9.772], [111.852, 9.772], [110.228, 8.148], [110.228, 5.852], [111.852, 4.228], [114.148, 4.228], [115.772, 5.852]];  // corner bolt window, 8 points
void_4 = [[9.772, 74.148], [8.148, 75.772], [5.852, 75.772], [4.228, 74.148], [4.228, 71.852], [5.852, 70.228], [8.148, 70.228], [9.772, 71.852]];  // corner bolt window, 8 points
void_5 = [[115.772, 74.148], [114.148, 75.772], [111.852, 75.772], [110.228, 74.148], [110.228, 71.852], [111.852, 70.228], [114.148, 70.228], [115.772, 71.852]];  // corner bolt window, 8 points

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
