$fn = 32;

// ----------------------------------------------------------------------
// Spacer plate: rect 100 x 60
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_r = 12;              // centre bore radius
bolt_r = 3.5;             // bolt hole radius
plate_t = 5;              // plate thickness, Z (extrusion height)
plate_l = 100;            // plate length, X
plate_w = 60;             // plate width, Y
inset = 14;               // corner hole inset
fit_tol = 0.05;           // declared fit tolerance (prompt contract)
free_tol = 0.3;           // declared free tolerance (prompt contract)

profile = [[3, 0], [97, 0], [100, 3], [100, 57], [97, 60], [3, 60], [0, 57], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[61.78, 32.29], [60.286, 36.18], [57.552, 39.326], [53.907, 41.346], [49.791, 41.998], [45.7, 41.203], [42.127, 39.057], [39.505, 35.818], [38.148, 31.877], [38.22, 27.71], [39.714, 23.82], [42.448, 20.674], [46.093, 18.654], [50.209, 18.002], [54.3, 18.797], [57.873, 20.943], [60.495, 24.182], [61.852, 28.123]];  // centre bore, 18 points
void_2 = [[17.436, 14.668], [16.641, 16.296], [15.139, 17.309], [13.332, 17.436], [11.704, 16.641], [10.691, 15.139], [10.564, 13.332], [11.359, 11.704], [12.861, 10.691], [14.668, 10.564], [16.296, 11.359], [17.309, 12.861]];  // corner hole, 12 points
void_3 = [[17.436, 46.668], [16.641, 48.296], [15.139, 49.309], [13.332, 49.436], [11.704, 48.641], [10.691, 47.139], [10.564, 45.332], [11.359, 43.704], [12.861, 42.691], [14.668, 42.564], [16.296, 43.359], [17.309, 44.861]];  // corner hole, 12 points
void_4 = [[89.436, 14.668], [88.641, 16.296], [87.139, 17.309], [85.332, 17.436], [83.704, 16.641], [82.691, 15.139], [82.564, 13.332], [83.359, 11.704], [84.861, 10.691], [86.668, 10.564], [88.296, 11.359], [89.309, 12.861]];  // corner hole, 12 points
void_5 = [[89.436, 46.668], [88.641, 48.296], [87.139, 49.309], [85.332, 49.436], [83.704, 48.641], [82.691, 47.139], [82.564, 45.332], [83.359, 43.704], [84.861, 42.691], [86.668, 42.564], [88.296, 43.359], [89.309, 44.861]];  // corner hole, 12 points

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
