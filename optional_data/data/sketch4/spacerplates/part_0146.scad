$fn = 32;

// ----------------------------------------------------------------------
// Spacer plate: rect 80 x 50
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_r = 10;              // centre bore radius
bolt_r = 3;               // bolt hole radius
plate_t = 5;              // plate thickness, Z (extrusion height)
plate_l = 80;             // plate length, X
plate_w = 50;             // plate width, Y
inset = 10;               // corner hole inset
fit_tol = 0.02;           // declared fit tolerance (prompt contract)
free_tol = 0.2;           // declared free tolerance (prompt contract)

profile = [[3, 0], [77, 0], [80, 3], [80, 47], [77, 50], [3, 50], [0, 47], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[49.816, 26.908], [48.572, 30.15], [46.293, 32.771], [43.256, 34.455], [39.825, 34.998], [36.416, 34.336], [33.439, 32.547], [31.254, 29.848], [30.123, 26.564], [30.184, 23.092], [31.428, 19.85], [33.707, 17.229], [36.744, 15.545], [40.175, 15.002], [43.584, 15.664], [46.561, 17.453], [48.746, 20.152], [49.877, 23.436]];  // centre bore, 18 points
void_2 = [[12.945, 10.572], [12.264, 11.968], [10.977, 12.837], [9.428, 12.945], [8.032, 12.264], [7.163, 10.977], [7.055, 9.428], [7.736, 8.032], [9.023, 7.163], [10.572, 7.055], [11.968, 7.736], [12.837, 9.023]];  // corner hole, 12 points
void_3 = [[12.945, 40.572], [12.264, 41.968], [10.977, 42.837], [9.428, 42.945], [8.032, 42.264], [7.163, 40.977], [7.055, 39.428], [7.736, 38.032], [9.023, 37.163], [10.572, 37.055], [11.968, 37.736], [12.837, 39.023]];  // corner hole, 12 points
void_4 = [[72.945, 10.572], [72.264, 11.968], [70.977, 12.837], [69.428, 12.945], [68.032, 12.264], [67.163, 10.977], [67.055, 9.428], [67.736, 8.032], [69.023, 7.163], [70.572, 7.055], [71.968, 7.736], [72.837, 9.023]];  // corner hole, 12 points
void_5 = [[72.945, 40.572], [72.264, 41.968], [70.977, 42.837], [69.428, 42.945], [68.032, 42.264], [67.163, 40.977], [67.055, 39.428], [67.736, 38.032], [69.023, 37.163], [70.572, 37.055], [71.968, 37.736], [72.837, 39.023]];  // corner hole, 12 points

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
