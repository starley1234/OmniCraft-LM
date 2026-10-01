$fn = 32;

// ----------------------------------------------------------------------
// Bracket plate: slot plate 70 x 50
// ----------------------------------------------------------------------

// --- parameters (mm) ---
hole_r = 3;               // bolt hole radius
plate_t = 8;              // plate thickness, Z (extrusion height)
plate_l = 70;             // plate length
plate_w = 50;             // plate width
slot_l = 32;              // slot straight length
slot_r = 4;               // slot end radius

slot_len = slot_l + 2 * slot_r;
slot_w = 2 * slot_r;
hole_d2 = 2 * hole_r;

profile = [[4, 0], [66, 0], [70, 4], [70, 46], [66, 50], [4, 50], [0, 46], [0, 4]];  // primary outline, 8 points, counter clockwise
void_1 = [[51, 21], [52.531, 21.304], [53.828, 22.172], [54.696, 23.469], [55, 25], [54.696, 26.531], [53.828, 27.828], [52.531, 28.696], [51, 29], [19, 29], [17.469, 28.696], [16.172, 27.828], [15.304, 26.531], [15, 25], [15.304, 23.469], [16.172, 22.172], [17.469, 21.304], [19, 21]];  // grip slot, 18 points
void_2 = [[11.545, 41.972], [10.864, 43.368], [9.577, 44.237], [8.028, 44.345], [6.632, 43.664], [5.763, 42.377], [5.655, 40.828], [6.336, 39.432], [7.623, 38.563], [9.172, 38.455], [10.568, 39.136], [11.437, 40.423]];  // corner hole, 12 points
void_3 = [[11.545, 9.172], [10.864, 10.568], [9.577, 11.437], [8.028, 11.545], [6.632, 10.864], [5.763, 9.577], [5.655, 8.028], [6.336, 6.632], [7.623, 5.763], [9.172, 5.655], [10.568, 6.336], [11.437, 7.623]];  // corner hole, 12 points
void_4 = [[64.345, 41.972], [63.664, 43.368], [62.377, 44.237], [60.828, 44.345], [59.432, 43.664], [58.563, 42.377], [58.455, 40.828], [59.136, 39.432], [60.423, 38.563], [61.972, 38.455], [63.368, 39.136], [64.237, 40.423]];  // corner hole, 12 points
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
