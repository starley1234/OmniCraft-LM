$fn = 32;

// ----------------------------------------------------------------------
// Frame plate: 80 x 70 frame, 14 mm rails
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 80;             // plate length, X
plate_w = 70;             // plate width, Y
plate_t = 6;              // plate thickness, Z (extrusion height)
corner_c = 3;             // corner chamfer
frame_bar = 14;           // frame rail width
bolt_r = 4;               // corner bolt window radius
bolt_inset = 7;           // bolt centre inset from the edges

win_l = plate_l - 2 * frame_bar;  // window length
win_w = plate_w - 2 * frame_bar;  // window width
bolt_d = 2 * bolt_r;  // corner hole diameter

profile = [[3, 0], [77, 0], [80, 3], [80, 67], [77, 70], [3, 70], [0, 67], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[14, 14], [66, 14], [66, 56], [14, 56]];  // the window, 4 points
void_2 = [[10.696, 8.531], [8.531, 10.696], [5.469, 10.696], [3.304, 8.531], [3.304, 5.469], [5.469, 3.304], [8.531, 3.304], [10.696, 5.469]];  // corner bolt window, 8 points
void_3 = [[76.696, 8.531], [74.531, 10.696], [71.469, 10.696], [69.304, 8.531], [69.304, 5.469], [71.469, 3.304], [74.531, 3.304], [76.696, 5.469]];  // corner bolt window, 8 points
void_4 = [[10.696, 64.531], [8.531, 66.696], [5.469, 66.696], [3.304, 64.531], [3.304, 61.469], [5.469, 59.304], [8.531, 59.304], [10.696, 61.469]];  // corner bolt window, 8 points
void_5 = [[76.696, 64.531], [74.531, 66.696], [71.469, 66.696], [69.304, 64.531], [69.304, 61.469], [71.469, 59.304], [74.531, 59.304], [76.696, 61.469]];  // corner bolt window, 8 points

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
