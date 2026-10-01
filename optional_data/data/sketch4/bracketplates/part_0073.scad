$fn = 32;

// ----------------------------------------------------------------------
// Bracket plate: slot plate 90 x 50
// ----------------------------------------------------------------------

// --- parameters (mm) ---
hole_r = 3;               // bolt hole radius
plate_t = 8;              // plate thickness, Z (extrusion height)
plate_l = 90;             // plate length
plate_w = 50;             // plate width
slot_l = 24;              // slot straight length
slot_r = 5;               // slot end radius

slot_len = slot_l + 2 * slot_r;
slot_w = 2 * slot_r;
hole_d2 = 2 * hole_r;

profile = [[4, 0], [86, 0], [90, 4], [90, 46], [86, 50], [4, 50], [0, 46], [0, 4]];  // primary outline, 8 points, counter clockwise
void_1 = [[57, 20], [58.913, 20.381], [60.536, 21.464], [61.619, 23.087], [62, 25], [61.619, 26.913], [60.536, 28.536], [58.913, 29.619], [57, 30], [33, 30], [31.087, 29.619], [29.464, 28.536], [28.381, 26.913], [28, 25], [28.381, 23.087], [29.464, 21.464], [31.087, 20.381], [33, 20]];  // grip slot, 18 points
void_2 = [[11.545, 41.972], [10.864, 43.368], [9.577, 44.237], [8.028, 44.345], [6.632, 43.664], [5.763, 42.377], [5.655, 40.828], [6.336, 39.432], [7.623, 38.563], [9.172, 38.455], [10.568, 39.136], [11.437, 40.423]];  // corner hole, 12 points
void_3 = [[11.545, 9.172], [10.864, 10.568], [9.577, 11.437], [8.028, 11.545], [6.632, 10.864], [5.763, 9.577], [5.655, 8.028], [6.336, 6.632], [7.623, 5.763], [9.172, 5.655], [10.568, 6.336], [11.437, 7.623]];  // corner hole, 12 points
void_4 = [[84.345, 41.972], [83.664, 43.368], [82.377, 44.237], [80.828, 44.345], [79.432, 43.664], [78.563, 42.377], [78.455, 40.828], [79.136, 39.432], [80.423, 38.563], [81.972, 38.455], [83.368, 39.136], [84.237, 40.423]];  // corner hole, 12 points
void_5 = [[84.345, 9.172], [83.664, 10.568], [82.377, 11.437], [80.828, 11.545], [79.432, 10.864], [78.563, 9.577], [78.455, 8.028], [79.136, 6.632], [80.423, 5.763], [81.972, 5.655], [83.368, 6.336], [84.237, 7.623]];  // corner hole, 12 points

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
