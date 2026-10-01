$fn = 32;

// ----------------------------------------------------------------------
// Spacer plate: rect 100 x 45
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_r = 10;              // centre bore radius
bolt_r = 2.5;             // bolt hole radius
plate_t = 5;              // plate thickness, Z (extrusion height)
plate_l = 100;            // plate length, X
plate_w = 45;             // plate width, Y
inset = 14;               // corner hole inset
fit_tol = 0.1;            // declared fit tolerance (prompt contract)
free_tol = 0.5;           // declared free tolerance (prompt contract)

profile = [[3, 0], [97, 0], [100, 3], [100, 42], [97, 45], [3, 45], [0, 42], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[59.816, 24.408], [58.572, 27.65], [56.293, 30.271], [53.256, 31.955], [49.825, 32.498], [46.416, 31.836], [43.439, 30.047], [41.254, 27.348], [40.123, 24.064], [40.184, 20.592], [41.428, 17.35], [43.707, 14.729], [46.744, 13.045], [50.175, 12.502], [53.584, 13.164], [56.561, 14.953], [58.746, 17.652], [59.877, 20.936]];  // centre bore, 18 points
void_2 = [[16.454, 14.477], [15.887, 15.64], [14.814, 16.364], [13.523, 16.454], [12.36, 15.887], [11.636, 14.814], [11.546, 13.523], [12.113, 12.36], [13.186, 11.636], [14.477, 11.546], [15.64, 12.113], [16.364, 13.186]];  // corner hole, 12 points
void_3 = [[16.454, 31.477], [15.887, 32.64], [14.814, 33.364], [13.523, 33.454], [12.36, 32.887], [11.636, 31.814], [11.546, 30.523], [12.113, 29.36], [13.186, 28.636], [14.477, 28.546], [15.64, 29.113], [16.364, 30.186]];  // corner hole, 12 points
void_4 = [[88.454, 14.477], [87.887, 15.64], [86.814, 16.364], [85.523, 16.454], [84.36, 15.887], [83.636, 14.814], [83.546, 13.523], [84.113, 12.36], [85.186, 11.636], [86.477, 11.546], [87.64, 12.113], [88.364, 13.186]];  // corner hole, 12 points
void_5 = [[88.454, 31.477], [87.887, 32.64], [86.814, 33.364], [85.523, 33.454], [84.36, 32.887], [83.636, 31.814], [83.546, 30.523], [84.113, 29.36], [85.186, 28.636], [86.477, 28.546], [87.64, 29.113], [88.364, 30.186]];  // corner hole, 12 points

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
