$fn = 32;

// ----------------------------------------------------------------------
// Spacer plate: rect 100 x 60
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_r = 12;              // centre bore radius
bolt_r = 2.5;             // bolt hole radius
plate_t = 5;              // plate thickness, Z (extrusion height)
plate_l = 100;            // plate length, X
plate_w = 60;             // plate width, Y
inset = 10;               // corner hole inset

profile = [[3, 0], [97, 0], [100, 3], [100, 57], [97, 60], [3, 60], [0, 57], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[61.78, 32.29], [60.286, 36.18], [57.552, 39.326], [53.907, 41.346], [49.791, 41.998], [45.7, 41.203], [42.127, 39.057], [39.505, 35.818], [38.148, 31.877], [38.22, 27.71], [39.714, 23.82], [42.448, 20.674], [46.093, 18.654], [50.209, 18.002], [54.3, 18.797], [57.873, 20.943], [60.495, 24.182], [61.852, 28.123]];  // centre bore, 18 points
void_2 = [[12.454, 10.477], [11.887, 11.64], [10.814, 12.364], [9.523, 12.454], [8.36, 11.887], [7.636, 10.814], [7.546, 9.523], [8.113, 8.36], [9.186, 7.636], [10.477, 7.546], [11.64, 8.113], [12.364, 9.186]];  // corner hole, 12 points
void_3 = [[12.454, 50.477], [11.887, 51.64], [10.814, 52.364], [9.523, 52.454], [8.36, 51.887], [7.636, 50.814], [7.546, 49.523], [8.113, 48.36], [9.186, 47.636], [10.477, 47.546], [11.64, 48.113], [12.364, 49.186]];  // corner hole, 12 points
void_4 = [[92.454, 10.477], [91.887, 11.64], [90.814, 12.364], [89.523, 12.454], [88.36, 11.887], [87.636, 10.814], [87.546, 9.523], [88.113, 8.36], [89.186, 7.636], [90.477, 7.546], [91.64, 8.113], [92.364, 9.186]];  // corner hole, 12 points
void_5 = [[92.454, 50.477], [91.887, 51.64], [90.814, 52.364], [89.523, 52.454], [88.36, 51.887], [87.636, 50.814], [87.546, 49.523], [88.113, 48.36], [89.186, 47.636], [90.477, 47.546], [91.64, 48.113], [92.364, 49.186]];  // corner hole, 12 points

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
