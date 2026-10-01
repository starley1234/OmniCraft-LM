$fn = 32;

// ----------------------------------------------------------------------
// Bracket plate: slot plate 90 x 40
// ----------------------------------------------------------------------

// --- parameters (mm) ---
hole_r = 3.5;             // bolt hole radius
plate_t = 6;              // plate thickness, Z (extrusion height)
plate_l = 90;             // plate length
plate_w = 40;             // plate width
slot_l = 28;              // slot straight length
slot_r = 4;               // slot end radius

slot_len = slot_l + 2 * slot_r;
slot_w = 2 * slot_r;
hole_d2 = 2 * hole_r;

profile = [[4, 0], [86, 0], [90, 4], [90, 36], [86, 40], [4, 40], [0, 36], [0, 4]];  // primary outline, 8 points, counter clockwise
void_1 = [[59, 16], [60.531, 16.304], [61.828, 17.172], [62.696, 18.469], [63, 20], [62.696, 21.531], [61.828, 22.828], [60.531, 23.696], [59, 24], [31, 24], [29.469, 23.696], [28.172, 22.828], [27.304, 21.531], [27, 20], [27.304, 18.469], [28.172, 17.172], [29.469, 16.304], [31, 16]];  // grip slot, 18 points
void_2 = [[12.536, 31.568], [11.741, 33.196], [10.239, 34.209], [8.432, 34.336], [6.804, 33.541], [5.791, 32.039], [5.664, 30.232], [6.459, 28.604], [7.961, 27.591], [9.768, 27.464], [11.396, 28.259], [12.409, 29.761]];  // corner hole, 12 points
void_3 = [[12.536, 9.768], [11.741, 11.396], [10.239, 12.409], [8.432, 12.536], [6.804, 11.741], [5.791, 10.239], [5.664, 8.432], [6.459, 6.804], [7.961, 5.791], [9.768, 5.664], [11.396, 6.459], [12.409, 7.961]];  // corner hole, 12 points
void_4 = [[84.336, 31.568], [83.541, 33.196], [82.039, 34.209], [80.232, 34.336], [78.604, 33.541], [77.591, 32.039], [77.464, 30.232], [78.259, 28.604], [79.761, 27.591], [81.568, 27.464], [83.196, 28.259], [84.209, 29.761]];  // corner hole, 12 points
void_5 = [[84.336, 9.768], [83.541, 11.396], [82.039, 12.409], [80.232, 12.536], [78.604, 11.741], [77.591, 10.239], [77.464, 8.432], [78.259, 6.804], [79.761, 5.791], [81.568, 5.664], [83.196, 6.459], [84.209, 7.961]];  // corner hole, 12 points

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
