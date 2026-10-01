$fn = 32;

// ----------------------------------------------------------------------
// Frame plate: 110 x 70 frame, 16 mm rails
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 110;            // plate length, X
plate_w = 70;             // plate width, Y
plate_t = 6;              // plate thickness, Z (extrusion height)
corner_c = 3;             // corner chamfer
frame_bar = 16;           // frame rail width
bolt_r = 3;               // corner bolt window radius
bolt_inset = 8;           // bolt centre inset from the edges
fit_tol = 0.1;            // declared fit tolerance (prompt contract)
free_tol = 0.3;           // declared free tolerance (prompt contract)

win_l = plate_l - 2 * frame_bar;  // window length
win_w = plate_w - 2 * frame_bar;  // window width
bolt_d = 2 * bolt_r;  // corner hole diameter

profile = [[3, 0], [107, 0], [110, 3], [110, 67], [107, 70], [3, 70], [0, 67], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[16, 16], [94, 16], [94, 54], [16, 54]];  // the window, 4 points
void_2 = [[10.772, 9.148], [9.148, 10.772], [6.852, 10.772], [5.228, 9.148], [5.228, 6.852], [6.852, 5.228], [9.148, 5.228], [10.772, 6.852]];  // corner bolt window, 8 points
void_3 = [[104.772, 9.148], [103.148, 10.772], [100.852, 10.772], [99.228, 9.148], [99.228, 6.852], [100.852, 5.228], [103.148, 5.228], [104.772, 6.852]];  // corner bolt window, 8 points
void_4 = [[10.772, 63.148], [9.148, 64.772], [6.852, 64.772], [5.228, 63.148], [5.228, 60.852], [6.852, 59.228], [9.148, 59.228], [10.772, 60.852]];  // corner bolt window, 8 points
void_5 = [[104.772, 63.148], [103.148, 64.772], [100.852, 64.772], [99.228, 63.148], [99.228, 60.852], [100.852, 59.228], [103.148, 59.228], [104.772, 60.852]];  // corner bolt window, 8 points

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
