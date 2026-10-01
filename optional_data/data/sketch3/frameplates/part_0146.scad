$fn = 32;

// ----------------------------------------------------------------------
// Frame plate: 90 x 70 frame, 12 mm rails
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 90;             // plate length, X
plate_w = 70;             // plate width, Y
plate_t = 6;              // plate thickness, Z (extrusion height)
corner_c = 4;             // corner chamfer
frame_bar = 12;           // frame rail width
slot_l = 8;               // adjustment slot length
slot_w = 4;               // adjustment slot width

win_l = plate_l - 2 * frame_bar;  // window length
win_w = plate_w - 2 * frame_bar;  // window width

profile = [[4, 0], [86, 0], [90, 4], [90, 66], [86, 70], [4, 70], [0, 66], [0, 4]];  // primary outline, 8 points, counter clockwise
void_1 = [[12, 12], [78, 12], [78, 58], [12, 58]];  // the window, 4 points
void_2 = [[41, 4], [49, 4], [49, 8], [41, 8]];  // adjustment slot, 4 points
void_3 = [[41, 62], [49, 62], [49, 66], [41, 66]];  // adjustment slot, 4 points

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
