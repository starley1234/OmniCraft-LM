$fn = 32;

// ----------------------------------------------------------------------
// Bracket plate: slot plate 80 x 50
// ----------------------------------------------------------------------

// --- parameters (mm) ---
hole_r = 3;               // bolt hole radius
plate_t = 5;              // plate thickness, Z (extrusion height)
plate_l = 80;             // plate length
plate_w = 50;             // plate width
slot_l = 24;              // slot straight length
slot_r = 5;               // slot end radius
fit_tol = 0.05;           // declared fit tolerance (prompt contract)
free_tol = 0.2;           // declared free tolerance (prompt contract)

slot_len = slot_l + 2 * slot_r;
slot_w = 2 * slot_r;
hole_d2 = 2 * hole_r;

profile = [[4, 0], [76, 0], [80, 4], [80, 46], [76, 50], [4, 50], [0, 46], [0, 4]];  // primary outline, 8 points, counter clockwise
void_1 = [[52, 20], [53.913, 20.381], [55.536, 21.464], [56.619, 23.087], [57, 25], [56.619, 26.913], [55.536, 28.536], [53.913, 29.619], [52, 30], [28, 30], [26.087, 29.619], [24.464, 28.536], [23.381, 26.913], [23, 25], [23.381, 23.087], [24.464, 21.464], [26.087, 20.381], [28, 20]];  // grip slot, 18 points
void_2 = [[11.545, 41.972], [10.864, 43.368], [9.577, 44.237], [8.028, 44.345], [6.632, 43.664], [5.763, 42.377], [5.655, 40.828], [6.336, 39.432], [7.623, 38.563], [9.172, 38.455], [10.568, 39.136], [11.437, 40.423]];  // corner hole, 12 points
void_3 = [[11.545, 9.172], [10.864, 10.568], [9.577, 11.437], [8.028, 11.545], [6.632, 10.864], [5.763, 9.577], [5.655, 8.028], [6.336, 6.632], [7.623, 5.763], [9.172, 5.655], [10.568, 6.336], [11.437, 7.623]];  // corner hole, 12 points
void_4 = [[74.345, 41.972], [73.664, 43.368], [72.377, 44.237], [70.828, 44.345], [69.432, 43.664], [68.563, 42.377], [68.455, 40.828], [69.136, 39.432], [70.423, 38.563], [71.972, 38.455], [73.368, 39.136], [74.237, 40.423]];  // corner hole, 12 points
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
