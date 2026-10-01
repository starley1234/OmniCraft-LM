$fn = 32;

// ----------------------------------------------------------------------
// Frame plate: 90 x 60 frame, 16 mm rails
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 90;             // plate length, X
plate_w = 60;             // plate width, Y
plate_t = 6;              // plate thickness, Z (extrusion height)
corner_c = 4;             // corner chamfer
frame_bar = 16;           // frame rail width
slot_l = 12;              // adjustment slot length
slot_w = 4;               // adjustment slot width

win_l = plate_l - 2 * frame_bar;  // window length
win_w = plate_w - 2 * frame_bar;  // window width

profile = [[4, 0], [86, 0], [90, 4], [90, 56], [86, 60], [4, 60], [0, 56], [0, 4]];  // primary outline, 8 points, counter clockwise
void_1 = [[16, 16], [74, 16], [74, 44], [16, 44]];  // the window, 4 points
void_2 = [[39, 6], [51, 6], [51, 10], [39, 10]];  // adjustment slot, 4 points
void_3 = [[39, 50], [51, 50], [51, 54], [39, 54]];  // adjustment slot, 4 points

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
