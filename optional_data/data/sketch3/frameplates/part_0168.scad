$fn = 32;

// ----------------------------------------------------------------------
// Frame plate: 100 x 80 frame, 12 mm rails
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 100;            // plate length, X
plate_w = 80;             // plate width, Y
plate_t = 8;              // plate thickness, Z (extrusion height)
corner_c = 4;             // corner chamfer
frame_bar = 12;           // frame rail width
bolt_r = 3;               // corner bolt window radius
bolt_inset = 6;           // bolt centre inset from the edges

win_l = plate_l - 2 * frame_bar;  // window length
win_w = plate_w - 2 * frame_bar;  // window width
bolt_d = 2 * bolt_r;  // corner hole diameter

profile = [[4, 0], [96, 0], [100, 4], [100, 76], [96, 80], [4, 80], [0, 76], [0, 4]];  // primary outline, 8 points, counter clockwise
void_1 = [[12, 12], [88, 12], [88, 68], [12, 68]];  // the window, 4 points
void_2 = [[8.772, 7.148], [7.148, 8.772], [4.852, 8.772], [3.228, 7.148], [3.228, 4.852], [4.852, 3.228], [7.148, 3.228], [8.772, 4.852]];  // corner bolt window, 8 points
void_3 = [[96.772, 7.148], [95.148, 8.772], [92.852, 8.772], [91.228, 7.148], [91.228, 4.852], [92.852, 3.228], [95.148, 3.228], [96.772, 4.852]];  // corner bolt window, 8 points
void_4 = [[8.772, 75.148], [7.148, 76.772], [4.852, 76.772], [3.228, 75.148], [3.228, 72.852], [4.852, 71.228], [7.148, 71.228], [8.772, 72.852]];  // corner bolt window, 8 points
void_5 = [[96.772, 75.148], [95.148, 76.772], [92.852, 76.772], [91.228, 75.148], [91.228, 72.852], [92.852, 71.228], [95.148, 71.228], [96.772, 72.852]];  // corner bolt window, 8 points

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
