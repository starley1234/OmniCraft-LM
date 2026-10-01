$fn = 32;

// ----------------------------------------------------------------------
// Bracket plate: slot plate 70 x 45
// ----------------------------------------------------------------------

// --- parameters (mm) ---
hole_r = 3;               // bolt hole radius
plate_t = 6;              // plate thickness, Z (extrusion height)
plate_l = 70;             // plate length
plate_w = 45;             // plate width
slot_l = 24;              // slot straight length
slot_r = 4;               // slot end radius

slot_len = slot_l + 2 * slot_r;
slot_w = 2 * slot_r;
hole_d2 = 2 * hole_r;

profile = [[4, 0], [66, 0], [70, 4], [70, 41], [66, 45], [4, 45], [0, 41], [0, 4]];  // primary outline, 8 points, counter clockwise
void_1 = [[47, 18.5], [48.531, 18.804], [49.828, 19.672], [50.696, 20.969], [51, 22.5], [50.696, 24.031], [49.828, 25.328], [48.531, 26.196], [47, 26.5], [23, 26.5], [21.469, 26.196], [20.172, 25.328], [19.304, 24.031], [19, 22.5], [19.304, 20.969], [20.172, 19.672], [21.469, 18.804], [23, 18.5]];  // grip slot, 18 points
void_2 = [[11.545, 36.972], [10.864, 38.368], [9.577, 39.237], [8.028, 39.345], [6.632, 38.664], [5.763, 37.377], [5.655, 35.828], [6.336, 34.432], [7.623, 33.563], [9.172, 33.455], [10.568, 34.136], [11.437, 35.423]];  // corner hole, 12 points
void_3 = [[11.545, 9.172], [10.864, 10.568], [9.577, 11.437], [8.028, 11.545], [6.632, 10.864], [5.763, 9.577], [5.655, 8.028], [6.336, 6.632], [7.623, 5.763], [9.172, 5.655], [10.568, 6.336], [11.437, 7.623]];  // corner hole, 12 points
void_4 = [[64.345, 36.972], [63.664, 38.368], [62.377, 39.237], [60.828, 39.345], [59.432, 38.664], [58.563, 37.377], [58.455, 35.828], [59.136, 34.432], [60.423, 33.563], [61.972, 33.455], [63.368, 34.136], [64.237, 35.423]];  // corner hole, 12 points
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
