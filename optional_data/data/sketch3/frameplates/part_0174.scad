$fn = 32;

// ----------------------------------------------------------------------
// Frame plate: 110 x 70 frame, 16 mm rails
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 110;            // plate length, X
plate_w = 70;             // plate width, Y
plate_t = 8;              // plate thickness, Z (extrusion height)
corner_c = 5;             // corner chamfer
frame_bar = 16;           // frame rail width
bolt_r = 4;               // corner bolt window radius
bolt_inset = 8;           // bolt centre inset from the edges

win_l = plate_l - 2 * frame_bar;  // window length
win_w = plate_w - 2 * frame_bar;  // window width
bolt_d = 2 * bolt_r;  // corner hole diameter

profile = [[5, 0], [105, 0], [110, 5], [110, 65], [105, 70], [5, 70], [0, 65], [0, 5]];  // primary outline, 8 points, counter clockwise
void_1 = [[16, 16], [94, 16], [94, 54], [16, 54]];  // the window, 4 points
void_2 = [[11.696, 9.531], [9.531, 11.696], [6.469, 11.696], [4.304, 9.531], [4.304, 6.469], [6.469, 4.304], [9.531, 4.304], [11.696, 6.469]];  // corner bolt window, 8 points
void_3 = [[105.696, 9.531], [103.531, 11.696], [100.469, 11.696], [98.304, 9.531], [98.304, 6.469], [100.469, 4.304], [103.531, 4.304], [105.696, 6.469]];  // corner bolt window, 8 points
void_4 = [[11.696, 63.531], [9.531, 65.696], [6.469, 65.696], [4.304, 63.531], [4.304, 60.469], [6.469, 58.304], [9.531, 58.304], [11.696, 60.469]];  // corner bolt window, 8 points
void_5 = [[105.696, 63.531], [103.531, 65.696], [100.469, 65.696], [98.304, 63.531], [98.304, 60.469], [100.469, 58.304], [103.531, 58.304], [105.696, 60.469]];  // corner bolt window, 8 points

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
