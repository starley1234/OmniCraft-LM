$fn = 32;

// ----------------------------------------------------------------------
// Frame plate: 80 x 60 frame, 14 mm rails
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 80;             // plate length, X
plate_w = 60;             // plate width, Y
plate_t = 6;              // plate thickness, Z (extrusion height)
corner_c = 3;             // corner chamfer
frame_bar = 14;           // frame rail width
bolt_r = 3;               // corner bolt window radius
bolt_inset = 7;           // bolt centre inset from the edges

win_l = plate_l - 2 * frame_bar;  // window length
win_w = plate_w - 2 * frame_bar;  // window width
bolt_d = 2 * bolt_r;  // corner hole diameter

profile = [[3, 0], [77, 0], [80, 3], [80, 57], [77, 60], [3, 60], [0, 57], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[14, 14], [66, 14], [66, 46], [14, 46]];  // the window, 4 points
void_2 = [[9.772, 8.148], [8.148, 9.772], [5.852, 9.772], [4.228, 8.148], [4.228, 5.852], [5.852, 4.228], [8.148, 4.228], [9.772, 5.852]];  // corner bolt window, 8 points
void_3 = [[75.772, 8.148], [74.148, 9.772], [71.852, 9.772], [70.228, 8.148], [70.228, 5.852], [71.852, 4.228], [74.148, 4.228], [75.772, 5.852]];  // corner bolt window, 8 points
void_4 = [[9.772, 54.148], [8.148, 55.772], [5.852, 55.772], [4.228, 54.148], [4.228, 51.852], [5.852, 50.228], [8.148, 50.228], [9.772, 51.852]];  // corner bolt window, 8 points
void_5 = [[75.772, 54.148], [74.148, 55.772], [71.852, 55.772], [70.228, 54.148], [70.228, 51.852], [71.852, 50.228], [74.148, 50.228], [75.772, 51.852]];  // corner bolt window, 8 points

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
