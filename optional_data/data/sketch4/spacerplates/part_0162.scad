$fn = 32;

// ----------------------------------------------------------------------
// Spacer plate: rect 80 x 50
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_r = 12;              // centre bore radius
bolt_r = 3.5;             // bolt hole radius
plate_t = 8;              // plate thickness, Z (extrusion height)
plate_l = 80;             // plate length, X
plate_w = 50;             // plate width, Y
inset = 10;               // corner hole inset
fit_tol = 0.02;           // declared fit tolerance (prompt contract)
free_tol = 0.2;           // declared free tolerance (prompt contract)

profile = [[3, 0], [77, 0], [80, 3], [80, 47], [77, 50], [3, 50], [0, 47], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[51.78, 27.29], [50.286, 31.18], [47.552, 34.326], [43.907, 36.346], [39.791, 36.998], [35.7, 36.203], [32.127, 34.057], [29.505, 30.818], [28.148, 26.877], [28.22, 22.71], [29.714, 18.82], [32.448, 15.674], [36.093, 13.654], [40.209, 13.002], [44.3, 13.797], [47.873, 15.943], [50.495, 19.182], [51.852, 23.123]];  // centre bore, 18 points
void_2 = [[13.436, 10.668], [12.641, 12.296], [11.139, 13.309], [9.332, 13.436], [7.704, 12.641], [6.691, 11.139], [6.564, 9.332], [7.359, 7.704], [8.861, 6.691], [10.668, 6.564], [12.296, 7.359], [13.309, 8.861]];  // corner hole, 12 points
void_3 = [[13.436, 40.668], [12.641, 42.296], [11.139, 43.309], [9.332, 43.436], [7.704, 42.641], [6.691, 41.139], [6.564, 39.332], [7.359, 37.704], [8.861, 36.691], [10.668, 36.564], [12.296, 37.359], [13.309, 38.861]];  // corner hole, 12 points
void_4 = [[73.436, 10.668], [72.641, 12.296], [71.139, 13.309], [69.332, 13.436], [67.704, 12.641], [66.691, 11.139], [66.564, 9.332], [67.359, 7.704], [68.861, 6.691], [70.668, 6.564], [72.296, 7.359], [73.309, 8.861]];  // corner hole, 12 points
void_5 = [[73.436, 40.668], [72.641, 42.296], [71.139, 43.309], [69.332, 43.436], [67.704, 42.641], [66.691, 41.139], [66.564, 39.332], [67.359, 37.704], [68.861, 36.691], [70.668, 36.564], [72.296, 37.359], [73.309, 38.861]];  // corner hole, 12 points

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
