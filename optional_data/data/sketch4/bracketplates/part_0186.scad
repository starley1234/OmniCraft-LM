$fn = 32;

// ----------------------------------------------------------------------
// Bracket plate: slot plate 80 x 45
// ----------------------------------------------------------------------

// --- parameters (mm) ---
hole_r = 3.5;             // bolt hole radius
plate_t = 6;              // plate thickness, Z (extrusion height)
plate_l = 80;             // plate length
plate_w = 45;             // plate width
slot_l = 32;              // slot straight length
slot_r = 5;               // slot end radius
fit_tol = 0.02;           // declared fit tolerance (prompt contract)
free_tol = 0.2;           // declared free tolerance (prompt contract)

slot_len = slot_l + 2 * slot_r;
slot_w = 2 * slot_r;
hole_d2 = 2 * hole_r;

profile = [[4, 0], [76, 0], [80, 4], [80, 41], [76, 45], [4, 45], [0, 41], [0, 4]];  // primary outline, 8 points, counter clockwise
void_1 = [[56, 17.5], [57.913, 17.881], [59.536, 18.964], [60.619, 20.587], [61, 22.5], [60.619, 24.413], [59.536, 26.036], [57.913, 27.119], [56, 27.5], [24, 27.5], [22.087, 27.119], [20.464, 26.036], [19.381, 24.413], [19, 22.5], [19.381, 20.587], [20.464, 18.964], [22.087, 17.881], [24, 17.5]];  // grip slot, 18 points
void_2 = [[12.536, 36.568], [11.741, 38.196], [10.239, 39.209], [8.432, 39.336], [6.804, 38.541], [5.791, 37.039], [5.664, 35.232], [6.459, 33.604], [7.961, 32.591], [9.768, 32.464], [11.396, 33.259], [12.409, 34.761]];  // corner hole, 12 points
void_3 = [[12.536, 9.768], [11.741, 11.396], [10.239, 12.409], [8.432, 12.536], [6.804, 11.741], [5.791, 10.239], [5.664, 8.432], [6.459, 6.804], [7.961, 5.791], [9.768, 5.664], [11.396, 6.459], [12.409, 7.961]];  // corner hole, 12 points
void_4 = [[74.336, 36.568], [73.541, 38.196], [72.039, 39.209], [70.232, 39.336], [68.604, 38.541], [67.591, 37.039], [67.464, 35.232], [68.259, 33.604], [69.761, 32.591], [71.568, 32.464], [73.196, 33.259], [74.209, 34.761]];  // corner hole, 12 points
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
