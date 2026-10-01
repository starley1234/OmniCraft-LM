$fn = 32;

// ----------------------------------------------------------------------
// Bracket plate: slot plate 70 x 40
// ----------------------------------------------------------------------

// --- parameters (mm) ---
hole_r = 3;               // bolt hole radius
plate_t = 6;              // plate thickness, Z (extrusion height)
plate_l = 70;             // plate length
plate_w = 40;             // plate width
slot_l = 32;              // slot straight length
slot_r = 5;               // slot end radius

slot_len = slot_l + 2 * slot_r;
slot_w = 2 * slot_r;
hole_d2 = 2 * hole_r;

profile = [[4, 0], [66, 0], [70, 4], [70, 36], [66, 40], [4, 40], [0, 36], [0, 4]];  // primary outline, 8 points, counter clockwise
void_1 = [[51, 15], [52.913, 15.381], [54.536, 16.464], [55.619, 18.087], [56, 20], [55.619, 21.913], [54.536, 23.536], [52.913, 24.619], [51, 25], [19, 25], [17.087, 24.619], [15.464, 23.536], [14.381, 21.913], [14, 20], [14.381, 18.087], [15.464, 16.464], [17.087, 15.381], [19, 15]];  // grip slot, 18 points
void_2 = [[11.545, 31.972], [10.864, 33.368], [9.577, 34.237], [8.028, 34.345], [6.632, 33.664], [5.763, 32.377], [5.655, 30.828], [6.336, 29.432], [7.623, 28.563], [9.172, 28.455], [10.568, 29.136], [11.437, 30.423]];  // corner hole, 12 points
void_3 = [[11.545, 9.172], [10.864, 10.568], [9.577, 11.437], [8.028, 11.545], [6.632, 10.864], [5.763, 9.577], [5.655, 8.028], [6.336, 6.632], [7.623, 5.763], [9.172, 5.655], [10.568, 6.336], [11.437, 7.623]];  // corner hole, 12 points
void_4 = [[64.345, 31.972], [63.664, 33.368], [62.377, 34.237], [60.828, 34.345], [59.432, 33.664], [58.563, 32.377], [58.455, 30.828], [59.136, 29.432], [60.423, 28.563], [61.972, 28.455], [63.368, 29.136], [64.237, 30.423]];  // corner hole, 12 points
void_5 = [[64.345, 9.172], [63.664, 10.568], [62.377, 11.437], [60.828, 11.545], [59.432, 10.864], [58.563, 9.577], [58.455, 8.028], [59.136, 6.632], [60.423, 5.763], [61.972, 5.655], [63.368, 6.336], [64.237, 7.623]];  // corner hole, 12 points

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
