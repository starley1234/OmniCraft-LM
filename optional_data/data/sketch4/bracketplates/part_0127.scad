$fn = 32;

// ----------------------------------------------------------------------
// Bracket plate: slot plate 70 x 50
// ----------------------------------------------------------------------

// --- parameters (mm) ---
hole_r = 3.5;             // bolt hole radius
plate_t = 5;              // plate thickness, Z (extrusion height)
plate_l = 70;             // plate length
plate_w = 50;             // plate width
slot_l = 28;              // slot straight length
slot_r = 5;               // slot end radius

slot_len = slot_l + 2 * slot_r;
slot_w = 2 * slot_r;
hole_d2 = 2 * hole_r;

profile = [[4, 0], [66, 0], [70, 4], [70, 46], [66, 50], [4, 50], [0, 46], [0, 4]];  // primary outline, 8 points, counter clockwise
void_1 = [[49, 20], [50.913, 20.381], [52.536, 21.464], [53.619, 23.087], [54, 25], [53.619, 26.913], [52.536, 28.536], [50.913, 29.619], [49, 30], [21, 30], [19.087, 29.619], [17.464, 28.536], [16.381, 26.913], [16, 25], [16.381, 23.087], [17.464, 21.464], [19.087, 20.381], [21, 20]];  // grip slot, 18 points
void_2 = [[12.536, 41.568], [11.741, 43.196], [10.239, 44.209], [8.432, 44.336], [6.804, 43.541], [5.791, 42.039], [5.664, 40.232], [6.459, 38.604], [7.961, 37.591], [9.768, 37.464], [11.396, 38.259], [12.409, 39.761]];  // corner hole, 12 points
void_3 = [[12.536, 9.768], [11.741, 11.396], [10.239, 12.409], [8.432, 12.536], [6.804, 11.741], [5.791, 10.239], [5.664, 8.432], [6.459, 6.804], [7.961, 5.791], [9.768, 5.664], [11.396, 6.459], [12.409, 7.961]];  // corner hole, 12 points
void_4 = [[64.336, 41.568], [63.541, 43.196], [62.039, 44.209], [60.232, 44.336], [58.604, 43.541], [57.591, 42.039], [57.464, 40.232], [58.259, 38.604], [59.761, 37.591], [61.568, 37.464], [63.196, 38.259], [64.209, 39.761]];  // corner hole, 12 points
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
