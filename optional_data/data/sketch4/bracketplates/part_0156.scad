$fn = 32;

// ----------------------------------------------------------------------
// Bracket plate: slot plate 90 x 45
// ----------------------------------------------------------------------

// --- parameters (mm) ---
hole_r = 3.5;             // bolt hole radius
plate_t = 6;              // plate thickness, Z (extrusion height)
plate_l = 90;             // plate length
plate_w = 45;             // plate width
slot_l = 32;              // slot straight length
slot_r = 5;               // slot end radius

slot_len = slot_l + 2 * slot_r;
slot_w = 2 * slot_r;
hole_d2 = 2 * hole_r;

profile = [[4, 0], [86, 0], [90, 4], [90, 41], [86, 45], [4, 45], [0, 41], [0, 4]];  // primary outline, 8 points, counter clockwise
void_1 = [[61, 17.5], [62.913, 17.881], [64.536, 18.964], [65.619, 20.587], [66, 22.5], [65.619, 24.413], [64.536, 26.036], [62.913, 27.119], [61, 27.5], [29, 27.5], [27.087, 27.119], [25.464, 26.036], [24.381, 24.413], [24, 22.5], [24.381, 20.587], [25.464, 18.964], [27.087, 17.881], [29, 17.5]];  // grip slot, 18 points
void_2 = [[12.536, 36.568], [11.741, 38.196], [10.239, 39.209], [8.432, 39.336], [6.804, 38.541], [5.791, 37.039], [5.664, 35.232], [6.459, 33.604], [7.961, 32.591], [9.768, 32.464], [11.396, 33.259], [12.409, 34.761]];  // corner hole, 12 points
void_3 = [[12.536, 9.768], [11.741, 11.396], [10.239, 12.409], [8.432, 12.536], [6.804, 11.741], [5.791, 10.239], [5.664, 8.432], [6.459, 6.804], [7.961, 5.791], [9.768, 5.664], [11.396, 6.459], [12.409, 7.961]];  // corner hole, 12 points
void_4 = [[84.336, 36.568], [83.541, 38.196], [82.039, 39.209], [80.232, 39.336], [78.604, 38.541], [77.591, 37.039], [77.464, 35.232], [78.259, 33.604], [79.761, 32.591], [81.568, 32.464], [83.196, 33.259], [84.209, 34.761]];  // corner hole, 12 points
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
