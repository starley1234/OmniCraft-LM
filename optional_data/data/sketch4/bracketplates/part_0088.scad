$fn = 32;

// ----------------------------------------------------------------------
// Bracket plate: slot plate 80 x 50
// ----------------------------------------------------------------------

// --- parameters (mm) ---
hole_r = 3.5;             // bolt hole radius
plate_t = 8;              // plate thickness, Z (extrusion height)
plate_l = 80;             // plate length
plate_w = 50;             // plate width
slot_l = 24;              // slot straight length
slot_r = 5;               // slot end radius

slot_len = slot_l + 2 * slot_r;
slot_w = 2 * slot_r;
hole_d2 = 2 * hole_r;

profile = [[4, 0], [76, 0], [80, 4], [80, 46], [76, 50], [4, 50], [0, 46], [0, 4]];  // primary outline, 8 points, counter clockwise
void_1 = [[52, 20], [53.913, 20.381], [55.536, 21.464], [56.619, 23.087], [57, 25], [56.619, 26.913], [55.536, 28.536], [53.913, 29.619], [52, 30], [28, 30], [26.087, 29.619], [24.464, 28.536], [23.381, 26.913], [23, 25], [23.381, 23.087], [24.464, 21.464], [26.087, 20.381], [28, 20]];  // grip slot, 18 points
void_2 = [[12.536, 41.568], [11.741, 43.196], [10.239, 44.209], [8.432, 44.336], [6.804, 43.541], [5.791, 42.039], [5.664, 40.232], [6.459, 38.604], [7.961, 37.591], [9.768, 37.464], [11.396, 38.259], [12.409, 39.761]];  // corner hole, 12 points
void_3 = [[12.536, 9.768], [11.741, 11.396], [10.239, 12.409], [8.432, 12.536], [6.804, 11.741], [5.791, 10.239], [5.664, 8.432], [6.459, 6.804], [7.961, 5.791], [9.768, 5.664], [11.396, 6.459], [12.409, 7.961]];  // corner hole, 12 points
void_4 = [[74.336, 41.568], [73.541, 43.196], [72.039, 44.209], [70.232, 44.336], [68.604, 43.541], [67.591, 42.039], [67.464, 40.232], [68.259, 38.604], [69.761, 37.591], [71.568, 37.464], [73.196, 38.259], [74.209, 39.761]];  // corner hole, 12 points
void_5 = [[74.336, 9.768], [73.541, 11.396], [72.039, 12.409], [70.232, 12.536], [68.604, 11.741], [67.591, 10.239], [67.464, 8.432], [68.259, 6.804], [69.761, 5.791], [71.568, 5.664], [73.196, 6.459], [74.209, 7.961]];  // corner hole, 12 points

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
