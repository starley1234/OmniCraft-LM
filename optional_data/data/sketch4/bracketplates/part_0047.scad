$fn = 32;

// ----------------------------------------------------------------------
// Bracket plate: slot plate 80 x 40
// ----------------------------------------------------------------------

// --- parameters (mm) ---
hole_r = 3.5;             // bolt hole radius
plate_t = 6;              // plate thickness, Z (extrusion height)
plate_l = 80;             // plate length
plate_w = 40;             // plate width
slot_l = 24;              // slot straight length
slot_r = 5;               // slot end radius
fit_tol = 0.05;           // declared fit tolerance (prompt contract)
free_tol = 0.3;           // declared free tolerance (prompt contract)

slot_len = slot_l + 2 * slot_r;
slot_w = 2 * slot_r;
hole_d2 = 2 * hole_r;

profile = [[4, 0], [76, 0], [80, 4], [80, 36], [76, 40], [4, 40], [0, 36], [0, 4]];  // primary outline, 8 points, counter clockwise
void_1 = [[52, 15], [53.913, 15.381], [55.536, 16.464], [56.619, 18.087], [57, 20], [56.619, 21.913], [55.536, 23.536], [53.913, 24.619], [52, 25], [28, 25], [26.087, 24.619], [24.464, 23.536], [23.381, 21.913], [23, 20], [23.381, 18.087], [24.464, 16.464], [26.087, 15.381], [28, 15]];  // grip slot, 18 points
void_2 = [[12.536, 31.568], [11.741, 33.196], [10.239, 34.209], [8.432, 34.336], [6.804, 33.541], [5.791, 32.039], [5.664, 30.232], [6.459, 28.604], [7.961, 27.591], [9.768, 27.464], [11.396, 28.259], [12.409, 29.761]];  // corner hole, 12 points
void_3 = [[12.536, 9.768], [11.741, 11.396], [10.239, 12.409], [8.432, 12.536], [6.804, 11.741], [5.791, 10.239], [5.664, 8.432], [6.459, 6.804], [7.961, 5.791], [9.768, 5.664], [11.396, 6.459], [12.409, 7.961]];  // corner hole, 12 points
void_4 = [[74.336, 31.568], [73.541, 33.196], [72.039, 34.209], [70.232, 34.336], [68.604, 33.541], [67.591, 32.039], [67.464, 30.232], [68.259, 28.604], [69.761, 27.591], [71.568, 27.464], [73.196, 28.259], [74.209, 29.761]];  // corner hole, 12 points
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
