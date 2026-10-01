$fn = 32;

// ----------------------------------------------------------------------
// Spacer plate: rect 100 x 50
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_r = 12;              // centre bore radius
bolt_r = 2.5;             // bolt hole radius
plate_t = 5;              // plate thickness, Z (extrusion height)
plate_l = 100;            // plate length, X
plate_w = 50;             // plate width, Y
inset = 10;               // corner hole inset

profile = [[3, 0], [97, 0], [100, 3], [100, 47], [97, 50], [3, 50], [0, 47], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[61.78, 27.29], [60.286, 31.18], [57.552, 34.326], [53.907, 36.346], [49.791, 36.998], [45.7, 36.203], [42.127, 34.057], [39.505, 30.818], [38.148, 26.877], [38.22, 22.71], [39.714, 18.82], [42.448, 15.674], [46.093, 13.654], [50.209, 13.002], [54.3, 13.797], [57.873, 15.943], [60.495, 19.182], [61.852, 23.123]];  // centre bore, 18 points
void_2 = [[12.454, 10.477], [11.887, 11.64], [10.814, 12.364], [9.523, 12.454], [8.36, 11.887], [7.636, 10.814], [7.546, 9.523], [8.113, 8.36], [9.186, 7.636], [10.477, 7.546], [11.64, 8.113], [12.364, 9.186]];  // corner hole, 12 points
void_3 = [[12.454, 40.477], [11.887, 41.64], [10.814, 42.364], [9.523, 42.454], [8.36, 41.887], [7.636, 40.814], [7.546, 39.523], [8.113, 38.36], [9.186, 37.636], [10.477, 37.546], [11.64, 38.113], [12.364, 39.186]];  // corner hole, 12 points
void_4 = [[92.454, 10.477], [91.887, 11.64], [90.814, 12.364], [89.523, 12.454], [88.36, 11.887], [87.636, 10.814], [87.546, 9.523], [88.113, 8.36], [89.186, 7.636], [90.477, 7.546], [91.64, 8.113], [92.364, 9.186]];  // corner hole, 12 points
void_5 = [[92.454, 40.477], [91.887, 41.64], [90.814, 42.364], [89.523, 42.454], [88.36, 41.887], [87.636, 40.814], [87.546, 39.523], [88.113, 38.36], [89.186, 37.636], [90.477, 37.546], [91.64, 38.113], [92.364, 39.186]];  // corner hole, 12 points

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
