$fn = 32;

// ----------------------------------------------------------------------
// Bracket plate: slot plate 80 x 45
// ----------------------------------------------------------------------

// --- parameters (mm) ---
hole_r = 3;               // bolt hole radius
plate_t = 6;              // plate thickness, Z (extrusion height)
plate_l = 80;             // plate length
plate_w = 45;             // plate width
slot_l = 24;              // slot straight length
slot_r = 4;               // slot end radius

slot_len = slot_l + 2 * slot_r;
slot_w = 2 * slot_r;
hole_d2 = 2 * hole_r;

profile = [[4, 0], [76, 0], [80, 4], [80, 41], [76, 45], [4, 45], [0, 41], [0, 4]];  // primary outline, 8 points, counter clockwise
void_1 = [[52, 18.5], [53.531, 18.804], [54.828, 19.672], [55.696, 20.969], [56, 22.5], [55.696, 24.031], [54.828, 25.328], [53.531, 26.196], [52, 26.5], [28, 26.5], [26.469, 26.196], [25.172, 25.328], [24.304, 24.031], [24, 22.5], [24.304, 20.969], [25.172, 19.672], [26.469, 18.804], [28, 18.5]];  // grip slot, 18 points
void_2 = [[11.545, 36.972], [10.864, 38.368], [9.577, 39.237], [8.028, 39.345], [6.632, 38.664], [5.763, 37.377], [5.655, 35.828], [6.336, 34.432], [7.623, 33.563], [9.172, 33.455], [10.568, 34.136], [11.437, 35.423]];  // corner hole, 12 points
void_3 = [[11.545, 9.172], [10.864, 10.568], [9.577, 11.437], [8.028, 11.545], [6.632, 10.864], [5.763, 9.577], [5.655, 8.028], [6.336, 6.632], [7.623, 5.763], [9.172, 5.655], [10.568, 6.336], [11.437, 7.623]];  // corner hole, 12 points
void_4 = [[74.345, 36.972], [73.664, 38.368], [72.377, 39.237], [70.828, 39.345], [69.432, 38.664], [68.563, 37.377], [68.455, 35.828], [69.136, 34.432], [70.423, 33.563], [71.972, 33.455], [73.368, 34.136], [74.237, 35.423]];  // corner hole, 12 points
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
