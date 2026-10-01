$fn = 32;

// ----------------------------------------------------------------------
// Spacer plate: rect 100 x 50
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_r = 10;              // centre bore radius
bolt_r = 3.5;             // bolt hole radius
plate_t = 8;              // plate thickness, Z (extrusion height)
plate_l = 100;            // plate length, X
plate_w = 50;             // plate width, Y
inset = 10;               // corner hole inset
fit_tol = 0.02;           // declared fit tolerance (prompt contract)
free_tol = 0.2;           // declared free tolerance (prompt contract)

profile = [[3, 0], [97, 0], [100, 3], [100, 47], [97, 50], [3, 50], [0, 47], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[59.816, 26.908], [58.572, 30.15], [56.293, 32.771], [53.256, 34.455], [49.825, 34.998], [46.416, 34.336], [43.439, 32.547], [41.254, 29.848], [40.123, 26.564], [40.184, 23.092], [41.428, 19.85], [43.707, 17.229], [46.744, 15.545], [50.175, 15.002], [53.584, 15.664], [56.561, 17.453], [58.746, 20.152], [59.877, 23.436]];  // centre bore, 18 points
void_2 = [[13.436, 10.668], [12.641, 12.296], [11.139, 13.309], [9.332, 13.436], [7.704, 12.641], [6.691, 11.139], [6.564, 9.332], [7.359, 7.704], [8.861, 6.691], [10.668, 6.564], [12.296, 7.359], [13.309, 8.861]];  // corner hole, 12 points
void_3 = [[13.436, 40.668], [12.641, 42.296], [11.139, 43.309], [9.332, 43.436], [7.704, 42.641], [6.691, 41.139], [6.564, 39.332], [7.359, 37.704], [8.861, 36.691], [10.668, 36.564], [12.296, 37.359], [13.309, 38.861]];  // corner hole, 12 points
void_4 = [[93.436, 10.668], [92.641, 12.296], [91.139, 13.309], [89.332, 13.436], [87.704, 12.641], [86.691, 11.139], [86.564, 9.332], [87.359, 7.704], [88.861, 6.691], [90.668, 6.564], [92.296, 7.359], [93.309, 8.861]];  // corner hole, 12 points
void_5 = [[93.436, 40.668], [92.641, 42.296], [91.139, 43.309], [89.332, 43.436], [87.704, 42.641], [86.691, 41.139], [86.564, 39.332], [87.359, 37.704], [88.861, 36.691], [90.668, 36.564], [92.296, 37.359], [93.309, 38.861]];  // corner hole, 12 points

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
