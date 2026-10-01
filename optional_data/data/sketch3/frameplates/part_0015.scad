$fn = 32;

// ----------------------------------------------------------------------
// Frame plate: 100 x 70 frame, 14 mm rails
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 100;            // plate length, X
plate_w = 70;             // plate width, Y
plate_t = 10;             // plate thickness, Z (extrusion height)
corner_c = 3;             // corner chamfer
frame_bar = 14;           // frame rail width
bolt_r = 3;               // corner bolt window radius
bolt_inset = 7;           // bolt centre inset from the edges
fit_tol = 0.05;           // declared fit tolerance (prompt contract)
free_tol = 0.2;           // declared free tolerance (prompt contract)

win_l = plate_l - 2 * frame_bar;  // window length
win_w = plate_w - 2 * frame_bar;  // window width
bolt_d = 2 * bolt_r;  // corner hole diameter

profile = [[3, 0], [97, 0], [100, 3], [100, 67], [97, 70], [3, 70], [0, 67], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[14, 14], [86, 14], [86, 56], [14, 56]];  // the window, 4 points
void_2 = [[9.772, 8.148], [8.148, 9.772], [5.852, 9.772], [4.228, 8.148], [4.228, 5.852], [5.852, 4.228], [8.148, 4.228], [9.772, 5.852]];  // corner bolt window, 8 points
void_3 = [[95.772, 8.148], [94.148, 9.772], [91.852, 9.772], [90.228, 8.148], [90.228, 5.852], [91.852, 4.228], [94.148, 4.228], [95.772, 5.852]];  // corner bolt window, 8 points
void_4 = [[9.772, 64.148], [8.148, 65.772], [5.852, 65.772], [4.228, 64.148], [4.228, 61.852], [5.852, 60.228], [8.148, 60.228], [9.772, 61.852]];  // corner bolt window, 8 points
void_5 = [[95.772, 64.148], [94.148, 65.772], [91.852, 65.772], [90.228, 64.148], [90.228, 61.852], [91.852, 60.228], [94.148, 60.228], [95.772, 61.852]];  // corner bolt window, 8 points

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
