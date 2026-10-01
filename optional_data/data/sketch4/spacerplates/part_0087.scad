$fn = 32;

// ----------------------------------------------------------------------
// Spacer plate: rect 70 x 60
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_r = 12;              // centre bore radius
bolt_r = 2.5;             // bolt hole radius
plate_t = 5;              // plate thickness, Z (extrusion height)
plate_l = 70;             // plate length, X
plate_w = 60;             // plate width, Y
inset = 12;               // corner hole inset
fit_tol = 0.05;           // declared fit tolerance (prompt contract)
free_tol = 0.2;           // declared free tolerance (prompt contract)

profile = [[3, 0], [67, 0], [70, 3], [70, 57], [67, 60], [3, 60], [0, 57], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[46.78, 32.29], [45.286, 36.18], [42.552, 39.326], [38.907, 41.346], [34.791, 41.998], [30.7, 41.203], [27.127, 39.057], [24.505, 35.818], [23.148, 31.877], [23.22, 27.71], [24.714, 23.82], [27.448, 20.674], [31.093, 18.654], [35.209, 18.002], [39.3, 18.797], [42.873, 20.943], [45.495, 24.182], [46.852, 28.123]];  // centre bore, 18 points
void_2 = [[14.454, 12.477], [13.887, 13.64], [12.814, 14.364], [11.523, 14.454], [10.36, 13.887], [9.636, 12.814], [9.546, 11.523], [10.113, 10.36], [11.186, 9.636], [12.477, 9.546], [13.64, 10.113], [14.364, 11.186]];  // corner hole, 12 points
void_3 = [[14.454, 48.477], [13.887, 49.64], [12.814, 50.364], [11.523, 50.454], [10.36, 49.887], [9.636, 48.814], [9.546, 47.523], [10.113, 46.36], [11.186, 45.636], [12.477, 45.546], [13.64, 46.113], [14.364, 47.186]];  // corner hole, 12 points
void_4 = [[60.454, 12.477], [59.887, 13.64], [58.814, 14.364], [57.523, 14.454], [56.36, 13.887], [55.636, 12.814], [55.546, 11.523], [56.113, 10.36], [57.186, 9.636], [58.477, 9.546], [59.64, 10.113], [60.364, 11.186]];  // corner hole, 12 points
void_5 = [[60.454, 48.477], [59.887, 49.64], [58.814, 50.364], [57.523, 50.454], [56.36, 49.887], [55.636, 48.814], [55.546, 47.523], [56.113, 46.36], [57.186, 45.636], [58.477, 45.546], [59.64, 46.113], [60.364, 47.186]];  // corner hole, 12 points

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
