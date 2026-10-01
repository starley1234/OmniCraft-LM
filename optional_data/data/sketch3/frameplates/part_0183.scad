$fn = 32;

// ----------------------------------------------------------------------
// Frame plate: 90 x 70 frame, 12 mm rails
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 90;             // plate length, X
plate_w = 70;             // plate width, Y
plate_t = 8;              // plate thickness, Z (extrusion height)
corner_c = 4;             // corner chamfer
frame_bar = 12;           // frame rail width
bolt_r = 4;               // corner bolt window radius
bolt_inset = 6;           // bolt centre inset from the edges
fit_tol = 0.02;           // declared fit tolerance (prompt contract)
free_tol = 0.2;           // declared free tolerance (prompt contract)

win_l = plate_l - 2 * frame_bar;  // window length
win_w = plate_w - 2 * frame_bar;  // window width
bolt_d = 2 * bolt_r;  // corner hole diameter

profile = [[4, 0], [86, 0], [90, 4], [90, 66], [86, 70], [4, 70], [0, 66], [0, 4]];  // primary outline, 8 points, counter clockwise
void_1 = [[12, 12], [78, 12], [78, 58], [12, 58]];  // the window, 4 points
void_2 = [[9.696, 7.531], [7.531, 9.696], [4.469, 9.696], [2.304, 7.531], [2.304, 4.469], [4.469, 2.304], [7.531, 2.304], [9.696, 4.469]];  // corner bolt window, 8 points
void_3 = [[87.696, 7.531], [85.531, 9.696], [82.469, 9.696], [80.304, 7.531], [80.304, 4.469], [82.469, 2.304], [85.531, 2.304], [87.696, 4.469]];  // corner bolt window, 8 points
void_4 = [[9.696, 65.531], [7.531, 67.696], [4.469, 67.696], [2.304, 65.531], [2.304, 62.469], [4.469, 60.304], [7.531, 60.304], [9.696, 62.469]];  // corner bolt window, 8 points
void_5 = [[87.696, 65.531], [85.531, 67.696], [82.469, 67.696], [80.304, 65.531], [80.304, 62.469], [82.469, 60.304], [85.531, 60.304], [87.696, 62.469]];  // corner bolt window, 8 points

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
