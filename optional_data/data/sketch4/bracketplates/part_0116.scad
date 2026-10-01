$fn = 32;

// ----------------------------------------------------------------------
// Bracket plate: slot plate 90 x 45
// ----------------------------------------------------------------------

// --- parameters (mm) ---
hole_r = 3;               // bolt hole radius
plate_t = 6;              // plate thickness, Z (extrusion height)
plate_l = 90;             // plate length
plate_w = 45;             // plate width
slot_l = 32;              // slot straight length
slot_r = 4;               // slot end radius

slot_len = slot_l + 2 * slot_r;
slot_w = 2 * slot_r;
hole_d2 = 2 * hole_r;

profile = [[4, 0], [86, 0], [90, 4], [90, 41], [86, 45], [4, 45], [0, 41], [0, 4]];  // primary outline, 8 points, counter clockwise
void_1 = [[61, 18.5], [62.531, 18.804], [63.828, 19.672], [64.696, 20.969], [65, 22.5], [64.696, 24.031], [63.828, 25.328], [62.531, 26.196], [61, 26.5], [29, 26.5], [27.469, 26.196], [26.172, 25.328], [25.304, 24.031], [25, 22.5], [25.304, 20.969], [26.172, 19.672], [27.469, 18.804], [29, 18.5]];  // grip slot, 18 points
void_2 = [[11.545, 36.972], [10.864, 38.368], [9.577, 39.237], [8.028, 39.345], [6.632, 38.664], [5.763, 37.377], [5.655, 35.828], [6.336, 34.432], [7.623, 33.563], [9.172, 33.455], [10.568, 34.136], [11.437, 35.423]];  // corner hole, 12 points
void_3 = [[11.545, 9.172], [10.864, 10.568], [9.577, 11.437], [8.028, 11.545], [6.632, 10.864], [5.763, 9.577], [5.655, 8.028], [6.336, 6.632], [7.623, 5.763], [9.172, 5.655], [10.568, 6.336], [11.437, 7.623]];  // corner hole, 12 points
void_4 = [[84.345, 36.972], [83.664, 38.368], [82.377, 39.237], [80.828, 39.345], [79.432, 38.664], [78.563, 37.377], [78.455, 35.828], [79.136, 34.432], [80.423, 33.563], [81.972, 33.455], [83.368, 34.136], [84.237, 35.423]];  // corner hole, 12 points
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
