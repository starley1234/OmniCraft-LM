$fn = 32;

// ----------------------------------------------------------------------
// Frame plate: 90 x 80 frame, 12 mm rails
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 90;             // plate length, X
plate_w = 80;             // plate width, Y
plate_t = 6;              // plate thickness, Z (extrusion height)
corner_c = 4;             // corner chamfer
frame_bar = 12;           // frame rail width
bolt_r = 3.5;             // corner bolt window radius
bolt_inset = 6;           // bolt centre inset from the edges
fit_tol = 0.1;            // declared fit tolerance (prompt contract)
free_tol = 0.3;           // declared free tolerance (prompt contract)

win_l = plate_l - 2 * frame_bar;  // window length
win_w = plate_w - 2 * frame_bar;  // window width
bolt_d = 2 * bolt_r;  // corner hole diameter

profile = [[4, 0], [86, 0], [90, 4], [90, 76], [86, 80], [4, 80], [0, 76], [0, 4]];  // primary outline, 8 points, counter clockwise
void_1 = [[12, 12], [78, 12], [78, 68], [12, 68]];  // the window, 4 points
void_2 = [[9.234, 7.339], [7.339, 9.234], [4.661, 9.234], [2.766, 7.339], [2.766, 4.661], [4.661, 2.766], [7.339, 2.766], [9.234, 4.661]];  // corner bolt window, 8 points
void_3 = [[87.234, 7.339], [85.339, 9.234], [82.661, 9.234], [80.766, 7.339], [80.766, 4.661], [82.661, 2.766], [85.339, 2.766], [87.234, 4.661]];  // corner bolt window, 8 points
void_4 = [[9.234, 75.339], [7.339, 77.234], [4.661, 77.234], [2.766, 75.339], [2.766, 72.661], [4.661, 70.766], [7.339, 70.766], [9.234, 72.661]];  // corner bolt window, 8 points
void_5 = [[87.234, 75.339], [85.339, 77.234], [82.661, 77.234], [80.766, 75.339], [80.766, 72.661], [82.661, 70.766], [85.339, 70.766], [87.234, 72.661]];  // corner bolt window, 8 points

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
