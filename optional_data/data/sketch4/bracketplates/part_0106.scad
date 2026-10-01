$fn = 32;

// ----------------------------------------------------------------------
// Bracket plate: slot plate 70 x 40
// ----------------------------------------------------------------------

// --- parameters (mm) ---
hole_r = 3.5;             // bolt hole radius
plate_t = 6;              // plate thickness, Z (extrusion height)
plate_l = 70;             // plate length
plate_w = 40;             // plate width
slot_l = 28;              // slot straight length
slot_r = 5;               // slot end radius

slot_len = slot_l + 2 * slot_r;
slot_w = 2 * slot_r;
hole_d2 = 2 * hole_r;

profile = [[4, 0], [66, 0], [70, 4], [70, 36], [66, 40], [4, 40], [0, 36], [0, 4]];  // primary outline, 8 points, counter clockwise
void_1 = [[49, 15], [50.913, 15.381], [52.536, 16.464], [53.619, 18.087], [54, 20], [53.619, 21.913], [52.536, 23.536], [50.913, 24.619], [49, 25], [21, 25], [19.087, 24.619], [17.464, 23.536], [16.381, 21.913], [16, 20], [16.381, 18.087], [17.464, 16.464], [19.087, 15.381], [21, 15]];  // grip slot, 18 points
void_2 = [[12.536, 31.568], [11.741, 33.196], [10.239, 34.209], [8.432, 34.336], [6.804, 33.541], [5.791, 32.039], [5.664, 30.232], [6.459, 28.604], [7.961, 27.591], [9.768, 27.464], [11.396, 28.259], [12.409, 29.761]];  // corner hole, 12 points
void_3 = [[12.536, 9.768], [11.741, 11.396], [10.239, 12.409], [8.432, 12.536], [6.804, 11.741], [5.791, 10.239], [5.664, 8.432], [6.459, 6.804], [7.961, 5.791], [9.768, 5.664], [11.396, 6.459], [12.409, 7.961]];  // corner hole, 12 points
void_4 = [[64.336, 31.568], [63.541, 33.196], [62.039, 34.209], [60.232, 34.336], [58.604, 33.541], [57.591, 32.039], [57.464, 30.232], [58.259, 28.604], [59.761, 27.591], [61.568, 27.464], [63.196, 28.259], [64.209, 29.761]];  // corner hole, 12 points
void_5 = [[64.336, 9.768], [63.541, 11.396], [62.039, 12.409], [60.232, 12.536], [58.604, 11.741], [57.591, 10.239], [57.464, 8.432], [58.259, 6.804], [59.761, 5.791], [61.568, 5.664], [63.196, 6.459], [64.209, 7.961]];  // corner hole, 12 points

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
