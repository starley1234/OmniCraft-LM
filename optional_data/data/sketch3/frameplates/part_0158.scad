$fn = 32;

// ----------------------------------------------------------------------
// Frame plate: 80 x 60 frame, 14 mm rails
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 80;             // plate length, X
plate_w = 60;             // plate width, Y
plate_t = 6;              // plate thickness, Z (extrusion height)
corner_c = 5;             // corner chamfer
frame_bar = 14;           // frame rail width
bolt_r = 3.5;             // corner bolt window radius
bolt_inset = 7;           // bolt centre inset from the edges
fit_tol = 0.1;            // declared fit tolerance (prompt contract)
free_tol = 0.3;           // declared free tolerance (prompt contract)

win_l = plate_l - 2 * frame_bar;  // window length
win_w = plate_w - 2 * frame_bar;  // window width
bolt_d = 2 * bolt_r;  // corner hole diameter

profile = [[5, 0], [75, 0], [80, 5], [80, 55], [75, 60], [5, 60], [0, 55], [0, 5]];  // primary outline, 8 points, counter clockwise
void_1 = [[14, 14], [66, 14], [66, 46], [14, 46]];  // the window, 4 points
void_2 = [[10.234, 8.339], [8.339, 10.234], [5.661, 10.234], [3.766, 8.339], [3.766, 5.661], [5.661, 3.766], [8.339, 3.766], [10.234, 5.661]];  // corner bolt window, 8 points
void_3 = [[76.234, 8.339], [74.339, 10.234], [71.661, 10.234], [69.766, 8.339], [69.766, 5.661], [71.661, 3.766], [74.339, 3.766], [76.234, 5.661]];  // corner bolt window, 8 points
void_4 = [[10.234, 54.339], [8.339, 56.234], [5.661, 56.234], [3.766, 54.339], [3.766, 51.661], [5.661, 49.766], [8.339, 49.766], [10.234, 51.661]];  // corner bolt window, 8 points
void_5 = [[76.234, 54.339], [74.339, 56.234], [71.661, 56.234], [69.766, 54.339], [69.766, 51.661], [71.661, 49.766], [74.339, 49.766], [76.234, 51.661]];  // corner bolt window, 8 points

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
