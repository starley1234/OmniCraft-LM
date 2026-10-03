$fn = 32;
// target_bbox: 70, 45, 5
// ----------------------------------------------------------------------
// Bracket plate: slot plate 70 x 45
// ----------------------------------------------------------------------

// --- parameters (mm) ---
hole_r = 3.5;             // bolt hole radius
plate_t = 5;              // plate thickness, Z (extrusion height)
plate_l = 70;             // plate length
plate_w = 45;             // plate width
slot_l = 28;              // slot straight length
slot_r = 5;               // slot end radius

slot_len = slot_l + 2 * slot_r;
slot_w = 2 * slot_r;
hole_d2 = 2 * hole_r;

profile = [[4, 0], [66, 0], [70, 4], [70, 41], [66, 45], [4, 45], [0, 41], [0, 4]];  // primary outline, 8 points, counter clockwise
void_1 = [[49, 17.5], [50.913, 17.881], [52.536, 18.964], [53.619, 20.587], [54, 22.5], [53.619, 24.413], [52.536, 26.036], [50.913, 27.119], [49, 27.5], [21, 27.5], [19.087, 27.119], [17.464, 26.036], [16.381, 24.413], [16, 22.5], [16.381, 20.587], [17.464, 18.964], [19.087, 17.881], [21, 17.5]];  // grip slot, 18 points
void_2 = [[12.536, 36.568], [11.741, 38.196], [10.239, 39.209], [8.432, 39.336], [6.804, 38.541], [5.791, 37.039], [5.664, 35.232], [6.459, 33.604], [7.961, 32.591], [9.768, 32.464], [11.396, 33.259], [12.409, 34.761]];  // corner hole, 12 points
void_3 = [[12.536, 9.768], [11.741, 11.396], [10.239, 12.409], [8.432, 12.536], [6.804, 11.741], [5.791, 10.239], [5.664, 8.432], [6.459, 6.804], [7.961, 5.791], [9.768, 5.664], [11.396, 6.459], [12.409, 7.961]];  // corner hole, 12 points
void_4 = [[64.336, 36.568], [63.541, 38.196], [62.039, 39.209], [60.232, 39.336], [58.604, 38.541], [57.591, 37.039], [57.464, 35.232], [58.259, 33.604], [59.761, 32.591], [61.568, 32.464], [63.196, 33.259], [64.209, 34.761]];  // corner hole, 12 points
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
