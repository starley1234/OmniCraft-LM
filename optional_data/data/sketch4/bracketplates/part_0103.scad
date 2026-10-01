$fn = 32;

// ----------------------------------------------------------------------
// Bracket plate: slot plate 80 x 40
// ----------------------------------------------------------------------

// --- parameters (mm) ---
hole_r = 3;               // bolt hole radius
plate_t = 8;              // plate thickness, Z (extrusion height)
plate_l = 80;             // plate length
plate_w = 40;             // plate width
slot_l = 24;              // slot straight length
slot_r = 5;               // slot end radius

slot_len = slot_l + 2 * slot_r;
slot_w = 2 * slot_r;
hole_d2 = 2 * hole_r;

profile = [[4, 0], [76, 0], [80, 4], [80, 36], [76, 40], [4, 40], [0, 36], [0, 4]];  // primary outline, 8 points, counter clockwise
void_1 = [[52, 15], [53.913, 15.381], [55.536, 16.464], [56.619, 18.087], [57, 20], [56.619, 21.913], [55.536, 23.536], [53.913, 24.619], [52, 25], [28, 25], [26.087, 24.619], [24.464, 23.536], [23.381, 21.913], [23, 20], [23.381, 18.087], [24.464, 16.464], [26.087, 15.381], [28, 15]];  // grip slot, 18 points
void_2 = [[11.545, 31.972], [10.864, 33.368], [9.577, 34.237], [8.028, 34.345], [6.632, 33.664], [5.763, 32.377], [5.655, 30.828], [6.336, 29.432], [7.623, 28.563], [9.172, 28.455], [10.568, 29.136], [11.437, 30.423]];  // corner hole, 12 points
void_3 = [[11.545, 9.172], [10.864, 10.568], [9.577, 11.437], [8.028, 11.545], [6.632, 10.864], [5.763, 9.577], [5.655, 8.028], [6.336, 6.632], [7.623, 5.763], [9.172, 5.655], [10.568, 6.336], [11.437, 7.623]];  // corner hole, 12 points
void_4 = [[74.345, 31.972], [73.664, 33.368], [72.377, 34.237], [70.828, 34.345], [69.432, 33.664], [68.563, 32.377], [68.455, 30.828], [69.136, 29.432], [70.423, 28.563], [71.972, 28.455], [73.368, 29.136], [74.237, 30.423]];  // corner hole, 12 points
void_5 = [[74.345, 9.172], [73.664, 10.568], [72.377, 11.437], [70.828, 11.545], [69.432, 10.864], [68.563, 9.577], [68.455, 8.028], [69.136, 6.632], [70.423, 5.763], [71.972, 5.655], [73.368, 6.336], [74.237, 7.623]];  // corner hole, 12 points

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
