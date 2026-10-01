$fn = 32;

// ----------------------------------------------------------------------
// Frame plate: 80 x 60 frame, 16 mm rails
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 80;             // plate length, X
plate_w = 60;             // plate width, Y
plate_t = 8;              // plate thickness, Z (extrusion height)
corner_c = 3;             // corner chamfer
frame_bar = 16;           // frame rail width
bolt_r = 3;               // corner bolt window radius
bolt_inset = 8;           // bolt centre inset from the edges

win_l = plate_l - 2 * frame_bar;  // window length
win_w = plate_w - 2 * frame_bar;  // window width
bolt_d = 2 * bolt_r;  // corner hole diameter

profile = [[3, 0], [77, 0], [80, 3], [80, 57], [77, 60], [3, 60], [0, 57], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[16, 16], [64, 16], [64, 44], [16, 44]];  // the window, 4 points
void_2 = [[10.772, 9.148], [9.148, 10.772], [6.852, 10.772], [5.228, 9.148], [5.228, 6.852], [6.852, 5.228], [9.148, 5.228], [10.772, 6.852]];  // corner bolt window, 8 points
void_3 = [[74.772, 9.148], [73.148, 10.772], [70.852, 10.772], [69.228, 9.148], [69.228, 6.852], [70.852, 5.228], [73.148, 5.228], [74.772, 6.852]];  // corner bolt window, 8 points
void_4 = [[10.772, 53.148], [9.148, 54.772], [6.852, 54.772], [5.228, 53.148], [5.228, 50.852], [6.852, 49.228], [9.148, 49.228], [10.772, 50.852]];  // corner bolt window, 8 points
void_5 = [[74.772, 53.148], [73.148, 54.772], [70.852, 54.772], [69.228, 53.148], [69.228, 50.852], [70.852, 49.228], [73.148, 49.228], [74.772, 50.852]];  // corner bolt window, 8 points

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
