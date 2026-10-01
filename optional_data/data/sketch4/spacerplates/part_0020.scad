$fn = 32;

// ----------------------------------------------------------------------
// Spacer plate: rect 100 x 45
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_r = 10;              // centre bore radius
bolt_r = 3;               // bolt hole radius
plate_t = 8;              // plate thickness, Z (extrusion height)
plate_l = 100;            // plate length, X
plate_w = 45;             // plate width, Y
inset = 14;               // corner hole inset
fit_tol = 0.02;           // declared fit tolerance (prompt contract)
free_tol = 0.2;           // declared free tolerance (prompt contract)

profile = [[3, 0], [97, 0], [100, 3], [100, 42], [97, 45], [3, 45], [0, 42], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[59.816, 24.408], [58.572, 27.65], [56.293, 30.271], [53.256, 31.955], [49.825, 32.498], [46.416, 31.836], [43.439, 30.047], [41.254, 27.348], [40.123, 24.064], [40.184, 20.592], [41.428, 17.35], [43.707, 14.729], [46.744, 13.045], [50.175, 12.502], [53.584, 13.164], [56.561, 14.953], [58.746, 17.652], [59.877, 20.936]];  // centre bore, 18 points
void_2 = [[16.945, 14.572], [16.264, 15.968], [14.977, 16.837], [13.428, 16.945], [12.032, 16.264], [11.163, 14.977], [11.055, 13.428], [11.736, 12.032], [13.023, 11.163], [14.572, 11.055], [15.968, 11.736], [16.837, 13.023]];  // corner hole, 12 points
void_3 = [[16.945, 31.572], [16.264, 32.968], [14.977, 33.837], [13.428, 33.945], [12.032, 33.264], [11.163, 31.977], [11.055, 30.428], [11.736, 29.032], [13.023, 28.163], [14.572, 28.055], [15.968, 28.736], [16.837, 30.023]];  // corner hole, 12 points
void_4 = [[88.945, 14.572], [88.264, 15.968], [86.977, 16.837], [85.428, 16.945], [84.032, 16.264], [83.163, 14.977], [83.055, 13.428], [83.736, 12.032], [85.023, 11.163], [86.572, 11.055], [87.968, 11.736], [88.837, 13.023]];  // corner hole, 12 points
void_5 = [[88.945, 31.572], [88.264, 32.968], [86.977, 33.837], [85.428, 33.945], [84.032, 33.264], [83.163, 31.977], [83.055, 30.428], [83.736, 29.032], [85.023, 28.163], [86.572, 28.055], [87.968, 28.736], [88.837, 30.023]];  // corner hole, 12 points

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
