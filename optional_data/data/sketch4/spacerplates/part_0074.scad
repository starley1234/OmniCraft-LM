$fn = 32;

// ----------------------------------------------------------------------
// Spacer plate: rect 80 x 60
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_r = 8;               // centre bore radius
bolt_r = 3.5;             // bolt hole radius
plate_t = 5;              // plate thickness, Z (extrusion height)
plate_l = 80;             // plate length, X
plate_w = 60;             // plate width, Y
inset = 14;               // corner hole inset
fit_tol = 0.1;            // declared fit tolerance (prompt contract)
free_tol = 0.5;           // declared free tolerance (prompt contract)

profile = [[3, 0], [77, 0], [80, 3], [80, 57], [77, 60], [3, 60], [0, 57], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[47.853, 31.526], [46.857, 34.12], [45.035, 36.217], [42.605, 37.564], [39.86, 37.999], [37.133, 37.469], [34.752, 36.038], [33.003, 33.878], [32.098, 31.251], [32.147, 28.474], [33.143, 25.88], [34.965, 23.783], [37.395, 22.436], [40.14, 22.001], [42.867, 22.531], [45.248, 23.962], [46.997, 26.122], [47.902, 28.749]];  // centre bore, 18 points
void_2 = [[17.436, 14.668], [16.641, 16.296], [15.139, 17.309], [13.332, 17.436], [11.704, 16.641], [10.691, 15.139], [10.564, 13.332], [11.359, 11.704], [12.861, 10.691], [14.668, 10.564], [16.296, 11.359], [17.309, 12.861]];  // corner hole, 12 points
void_3 = [[17.436, 46.668], [16.641, 48.296], [15.139, 49.309], [13.332, 49.436], [11.704, 48.641], [10.691, 47.139], [10.564, 45.332], [11.359, 43.704], [12.861, 42.691], [14.668, 42.564], [16.296, 43.359], [17.309, 44.861]];  // corner hole, 12 points
void_4 = [[69.436, 14.668], [68.641, 16.296], [67.139, 17.309], [65.332, 17.436], [63.704, 16.641], [62.691, 15.139], [62.564, 13.332], [63.359, 11.704], [64.861, 10.691], [66.668, 10.564], [68.296, 11.359], [69.309, 12.861]];  // corner hole, 12 points
void_5 = [[69.436, 46.668], [68.641, 48.296], [67.139, 49.309], [65.332, 49.436], [63.704, 48.641], [62.691, 47.139], [62.564, 45.332], [63.359, 43.704], [64.861, 42.691], [66.668, 42.564], [68.296, 43.359], [69.309, 44.861]];  // corner hole, 12 points

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
