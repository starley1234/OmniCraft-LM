$fn = 32;

// ----------------------------------------------------------------------
// Frame plate: 110 x 80 frame, 16 mm rails
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 110;            // plate length, X
plate_w = 80;             // plate width, Y
plate_t = 10;             // plate thickness, Z (extrusion height)
corner_c = 5;             // corner chamfer
frame_bar = 16;           // frame rail width
bolt_r = 3;               // corner bolt window radius
bolt_inset = 8;           // bolt centre inset from the edges

win_l = plate_l - 2 * frame_bar;  // window length
win_w = plate_w - 2 * frame_bar;  // window width
bolt_d = 2 * bolt_r;  // corner hole diameter

profile = [[5, 0], [105, 0], [110, 5], [110, 75], [105, 80], [5, 80], [0, 75], [0, 5]];  // primary outline, 8 points, counter clockwise
void_1 = [[16, 16], [94, 16], [94, 64], [16, 64]];  // the window, 4 points
void_2 = [[10.772, 9.148], [9.148, 10.772], [6.852, 10.772], [5.228, 9.148], [5.228, 6.852], [6.852, 5.228], [9.148, 5.228], [10.772, 6.852]];  // corner bolt window, 8 points
void_3 = [[104.772, 9.148], [103.148, 10.772], [100.852, 10.772], [99.228, 9.148], [99.228, 6.852], [100.852, 5.228], [103.148, 5.228], [104.772, 6.852]];  // corner bolt window, 8 points
void_4 = [[10.772, 73.148], [9.148, 74.772], [6.852, 74.772], [5.228, 73.148], [5.228, 70.852], [6.852, 69.228], [9.148, 69.228], [10.772, 70.852]];  // corner bolt window, 8 points
void_5 = [[104.772, 73.148], [103.148, 74.772], [100.852, 74.772], [99.228, 73.148], [99.228, 70.852], [100.852, 69.228], [103.148, 69.228], [104.772, 70.852]];  // corner bolt window, 8 points

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
