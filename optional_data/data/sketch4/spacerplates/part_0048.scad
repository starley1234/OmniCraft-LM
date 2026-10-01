$fn = 32;

// ----------------------------------------------------------------------
// Spacer plate: rect 70 x 50
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_r = 12;              // centre bore radius
bolt_r = 2.5;             // bolt hole radius
plate_t = 6;              // plate thickness, Z (extrusion height)
plate_l = 70;             // plate length, X
plate_w = 50;             // plate width, Y
inset = 10;               // corner hole inset

profile = [[3, 0], [67, 0], [70, 3], [70, 47], [67, 50], [3, 50], [0, 47], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[46.78, 27.29], [45.286, 31.18], [42.552, 34.326], [38.907, 36.346], [34.791, 36.998], [30.7, 36.203], [27.127, 34.057], [24.505, 30.818], [23.148, 26.877], [23.22, 22.71], [24.714, 18.82], [27.448, 15.674], [31.093, 13.654], [35.209, 13.002], [39.3, 13.797], [42.873, 15.943], [45.495, 19.182], [46.852, 23.123]];  // centre bore, 18 points
void_2 = [[12.454, 10.477], [11.887, 11.64], [10.814, 12.364], [9.523, 12.454], [8.36, 11.887], [7.636, 10.814], [7.546, 9.523], [8.113, 8.36], [9.186, 7.636], [10.477, 7.546], [11.64, 8.113], [12.364, 9.186]];  // corner hole, 12 points
void_3 = [[12.454, 40.477], [11.887, 41.64], [10.814, 42.364], [9.523, 42.454], [8.36, 41.887], [7.636, 40.814], [7.546, 39.523], [8.113, 38.36], [9.186, 37.636], [10.477, 37.546], [11.64, 38.113], [12.364, 39.186]];  // corner hole, 12 points
void_4 = [[62.454, 10.477], [61.887, 11.64], [60.814, 12.364], [59.523, 12.454], [58.36, 11.887], [57.636, 10.814], [57.546, 9.523], [58.113, 8.36], [59.186, 7.636], [60.477, 7.546], [61.64, 8.113], [62.364, 9.186]];  // corner hole, 12 points
void_5 = [[62.454, 40.477], [61.887, 41.64], [60.814, 42.364], [59.523, 42.454], [58.36, 41.887], [57.636, 40.814], [57.546, 39.523], [58.113, 38.36], [59.186, 37.636], [60.477, 37.546], [61.64, 38.113], [62.364, 39.186]];  // corner hole, 12 points

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
