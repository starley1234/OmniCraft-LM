$fn = 32;

// ----------------------------------------------------------------------
// Frame plate: 100 x 80 frame, 12 mm rails
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 100;            // plate length, X
plate_w = 80;             // plate width, Y
plate_t = 6;              // plate thickness, Z (extrusion height)
corner_c = 5;             // corner chamfer
frame_bar = 12;           // frame rail width
bolt_r = 4;               // corner bolt window radius
bolt_inset = 6;           // bolt centre inset from the edges
fit_tol = 0.1;            // declared fit tolerance (prompt contract)
free_tol = 0.5;           // declared free tolerance (prompt contract)

win_l = plate_l - 2 * frame_bar;  // window length
win_w = plate_w - 2 * frame_bar;  // window width
bolt_d = 2 * bolt_r;  // corner hole diameter

profile = [[5, 0], [95, 0], [100, 5], [100, 75], [95, 80], [5, 80], [0, 75], [0, 5]];  // primary outline, 8 points, counter clockwise
void_1 = [[12, 12], [88, 12], [88, 68], [12, 68]];  // the window, 4 points
void_2 = [[9.696, 7.531], [7.531, 9.696], [4.469, 9.696], [2.304, 7.531], [2.304, 4.469], [4.469, 2.304], [7.531, 2.304], [9.696, 4.469]];  // corner bolt window, 8 points
void_3 = [[97.696, 7.531], [95.531, 9.696], [92.469, 9.696], [90.304, 7.531], [90.304, 4.469], [92.469, 2.304], [95.531, 2.304], [97.696, 4.469]];  // corner bolt window, 8 points
void_4 = [[9.696, 75.531], [7.531, 77.696], [4.469, 77.696], [2.304, 75.531], [2.304, 72.469], [4.469, 70.304], [7.531, 70.304], [9.696, 72.469]];  // corner bolt window, 8 points
void_5 = [[97.696, 75.531], [95.531, 77.696], [92.469, 77.696], [90.304, 75.531], [90.304, 72.469], [92.469, 70.304], [95.531, 70.304], [97.696, 72.469]];  // corner bolt window, 8 points

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
