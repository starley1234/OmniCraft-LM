$fn = 32;

// ----------------------------------------------------------------------
// Frame plate: 110 x 60 frame, 16 mm rails
// ----------------------------------------------------------------------

// --- parameters (mm) ---
plate_l = 110;            // plate length, X
plate_w = 60;             // plate width, Y
plate_t = 8;              // plate thickness, Z (extrusion height)
corner_c = 3;             // corner chamfer
frame_bar = 16;           // frame rail width
slot_l = 12;              // adjustment slot length
slot_w = 4;               // adjustment slot width

win_l = plate_l - 2 * frame_bar;  // window length
win_w = plate_w - 2 * frame_bar;  // window width

profile = [[3, 0], [107, 0], [110, 3], [110, 57], [107, 60], [3, 60], [0, 57], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[16, 16], [94, 16], [94, 44], [16, 44]];  // the window, 4 points
void_2 = [[49, 6], [61, 6], [61, 10], [49, 10]];  // adjustment slot, 4 points
void_3 = [[49, 50], [61, 50], [61, 54], [49, 54]];  // adjustment slot, 4 points

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
