$fn = 32;

// ----------------------------------------------------------------------
// Frame plate: 100 x 70 frame, 16 mm rails
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 100;            // plate length, X
plate_w = 70;             // plate width, Y
plate_t = 6;              // plate thickness, Z (extrusion height)
corner_c = 3;             // corner chamfer
frame_bar = 16;           // frame rail width
slot_l = 12;              // adjustment slot length
slot_w = 5;               // adjustment slot width

win_l = plate_l - 2 * frame_bar;  // window length
win_w = plate_w - 2 * frame_bar;  // window width

profile = [[3, 0], [97, 0], [100, 3], [100, 67], [97, 70], [3, 70], [0, 67], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[16, 16], [84, 16], [84, 54], [16, 54]];  // the window, 4 points
void_2 = [[44, 5.5], [56, 5.5], [56, 10.5], [44, 10.5]];  // adjustment slot, 4 points
void_3 = [[44, 59.5], [56, 59.5], [56, 64.5], [44, 64.5]];  // adjustment slot, 4 points

// --- the one profile operation ---
difference() {
  linear_extrude(height = plate_t) polygon(points = profile);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_1);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_2);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_3);
}
