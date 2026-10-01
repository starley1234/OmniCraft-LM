$fn = 32;

// ----------------------------------------------------------------------
// Frame plate: 100 x 70 frame, 16 mm rails
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 100;            // plate length, X
plate_w = 70;             // plate width, Y
plate_t = 10;             // plate thickness, Z (extrusion height)
corner_c = 4;             // corner chamfer
frame_bar = 16;           // frame rail width
bolt_r = 3;               // corner bolt window radius
bolt_inset = 8;           // bolt centre inset from the edges

win_l = plate_l - 2 * frame_bar;  // window length
win_w = plate_w - 2 * frame_bar;  // window width
bolt_d = 2 * bolt_r;  // corner hole diameter

profile = [[4, 0], [96, 0], [100, 4], [100, 66], [96, 70], [4, 70], [0, 66], [0, 4]];  // primary outline, 8 points, counter clockwise
void_1 = [[16, 16], [84, 16], [84, 54], [16, 54]];  // the window, 4 points
void_2 = [[10.772, 9.148], [9.148, 10.772], [6.852, 10.772], [5.228, 9.148], [5.228, 6.852], [6.852, 5.228], [9.148, 5.228], [10.772, 6.852]];  // corner bolt window, 8 points
void_3 = [[94.772, 9.148], [93.148, 10.772], [90.852, 10.772], [89.228, 9.148], [89.228, 6.852], [90.852, 5.228], [93.148, 5.228], [94.772, 6.852]];  // corner bolt window, 8 points
void_4 = [[10.772, 63.148], [9.148, 64.772], [6.852, 64.772], [5.228, 63.148], [5.228, 60.852], [6.852, 59.228], [9.148, 59.228], [10.772, 60.852]];  // corner bolt window, 8 points
void_5 = [[94.772, 63.148], [93.148, 64.772], [90.852, 64.772], [89.228, 63.148], [89.228, 60.852], [90.852, 59.228], [93.148, 59.228], [94.772, 60.852]];  // corner bolt window, 8 points

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
