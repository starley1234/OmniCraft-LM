$fn = 32;

// ----------------------------------------------------------------------
// Frame plate: 110 x 60 frame, 12 mm rails
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 110;            // plate length, X
plate_w = 60;             // plate width, Y
plate_t = 8;              // plate thickness, Z (extrusion height)
corner_c = 4;             // corner chamfer
frame_bar = 12;           // frame rail width
bolt_r = 3;               // corner bolt window radius
bolt_inset = 6;           // bolt centre inset from the edges

win_l = plate_l - 2 * frame_bar;  // window length
win_w = plate_w - 2 * frame_bar;  // window width
bolt_d = 2 * bolt_r;  // corner hole diameter

profile = [[4, 0], [106, 0], [110, 4], [110, 56], [106, 60], [4, 60], [0, 56], [0, 4]];  // primary outline, 8 points, counter clockwise
void_1 = [[12, 12], [98, 12], [98, 48], [12, 48]];  // the window, 4 points
void_2 = [[8.772, 7.148], [7.148, 8.772], [4.852, 8.772], [3.228, 7.148], [3.228, 4.852], [4.852, 3.228], [7.148, 3.228], [8.772, 4.852]];  // corner bolt window, 8 points
void_3 = [[106.772, 7.148], [105.148, 8.772], [102.852, 8.772], [101.228, 7.148], [101.228, 4.852], [102.852, 3.228], [105.148, 3.228], [106.772, 4.852]];  // corner bolt window, 8 points
void_4 = [[8.772, 55.148], [7.148, 56.772], [4.852, 56.772], [3.228, 55.148], [3.228, 52.852], [4.852, 51.228], [7.148, 51.228], [8.772, 52.852]];  // corner bolt window, 8 points
void_5 = [[106.772, 55.148], [105.148, 56.772], [102.852, 56.772], [101.228, 55.148], [101.228, 52.852], [102.852, 51.228], [105.148, 51.228], [106.772, 52.852]];  // corner bolt window, 8 points

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
