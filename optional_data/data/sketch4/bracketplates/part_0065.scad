$fn = 32;

// ----------------------------------------------------------------------
// Bracket plate: slot plate 90 x 50
// ----------------------------------------------------------------------

// --- parameters (mm) ---
hole_r = 3.5;             // bolt hole radius
plate_t = 5;              // plate thickness, Z (extrusion height)
plate_l = 90;             // plate length
plate_w = 50;             // plate width
slot_l = 28;              // slot straight length
slot_r = 5;               // slot end radius

slot_len = slot_l + 2 * slot_r;
slot_w = 2 * slot_r;
hole_d2 = 2 * hole_r;

profile = [[4, 0], [86, 0], [90, 4], [90, 46], [86, 50], [4, 50], [0, 46], [0, 4]];  // primary outline, 8 points, counter clockwise
void_1 = [[59, 20], [60.913, 20.381], [62.536, 21.464], [63.619, 23.087], [64, 25], [63.619, 26.913], [62.536, 28.536], [60.913, 29.619], [59, 30], [31, 30], [29.087, 29.619], [27.464, 28.536], [26.381, 26.913], [26, 25], [26.381, 23.087], [27.464, 21.464], [29.087, 20.381], [31, 20]];  // grip slot, 18 points
void_2 = [[12.536, 41.568], [11.741, 43.196], [10.239, 44.209], [8.432, 44.336], [6.804, 43.541], [5.791, 42.039], [5.664, 40.232], [6.459, 38.604], [7.961, 37.591], [9.768, 37.464], [11.396, 38.259], [12.409, 39.761]];  // corner hole, 12 points
void_3 = [[12.536, 9.768], [11.741, 11.396], [10.239, 12.409], [8.432, 12.536], [6.804, 11.741], [5.791, 10.239], [5.664, 8.432], [6.459, 6.804], [7.961, 5.791], [9.768, 5.664], [11.396, 6.459], [12.409, 7.961]];  // corner hole, 12 points
void_4 = [[84.336, 41.568], [83.541, 43.196], [82.039, 44.209], [80.232, 44.336], [78.604, 43.541], [77.591, 42.039], [77.464, 40.232], [78.259, 38.604], [79.761, 37.591], [81.568, 37.464], [83.196, 38.259], [84.209, 39.761]];  // corner hole, 12 points
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
