$fn = 32;

// ----------------------------------------------------------------------
// Frame plate: 90 x 60 frame, 12 mm rails
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 90;             // plate length, X
plate_w = 60;             // plate width, Y
plate_t = 8;              // plate thickness, Z (extrusion height)
corner_c = 3;             // corner chamfer
frame_bar = 12;           // frame rail width
slot_l = 8;               // adjustment slot length
slot_w = 5;               // adjustment slot width

win_l = plate_l - 2 * frame_bar;  // window length
win_w = plate_w - 2 * frame_bar;  // window width

profile = [[3, 0], [87, 0], [90, 3], [90, 57], [87, 60], [3, 60], [0, 57], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[12, 12], [78, 12], [78, 48], [12, 48]];  // the window, 4 points
void_2 = [[41, 3.5], [49, 3.5], [49, 8.5], [41, 8.5]];  // adjustment slot, 4 points
void_3 = [[41, 51.5], [49, 51.5], [49, 56.5], [41, 56.5]];  // adjustment slot, 4 points

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
