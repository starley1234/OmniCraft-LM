$fn = 32;

// ----------------------------------------------------------------------
// Spacer plate: rect 100 x 45
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_r = 10;              // centre bore radius
bolt_r = 2.5;             // bolt hole radius
plate_t = 8;              // plate thickness, Z (extrusion height)
plate_l = 100;            // plate length, X
plate_w = 45;             // plate width, Y
inset = 10;               // corner hole inset

profile = [[3, 0], [97, 0], [100, 3], [100, 42], [97, 45], [3, 45], [0, 42], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[59.816, 24.408], [58.572, 27.65], [56.293, 30.271], [53.256, 31.955], [49.825, 32.498], [46.416, 31.836], [43.439, 30.047], [41.254, 27.348], [40.123, 24.064], [40.184, 20.592], [41.428, 17.35], [43.707, 14.729], [46.744, 13.045], [50.175, 12.502], [53.584, 13.164], [56.561, 14.953], [58.746, 17.652], [59.877, 20.936]];  // centre bore, 18 points
void_2 = [[12.454, 10.477], [11.887, 11.64], [10.814, 12.364], [9.523, 12.454], [8.36, 11.887], [7.636, 10.814], [7.546, 9.523], [8.113, 8.36], [9.186, 7.636], [10.477, 7.546], [11.64, 8.113], [12.364, 9.186]];  // corner hole, 12 points
void_3 = [[12.454, 35.477], [11.887, 36.64], [10.814, 37.364], [9.523, 37.454], [8.36, 36.887], [7.636, 35.814], [7.546, 34.523], [8.113, 33.36], [9.186, 32.636], [10.477, 32.546], [11.64, 33.113], [12.364, 34.186]];  // corner hole, 12 points
void_4 = [[92.454, 10.477], [91.887, 11.64], [90.814, 12.364], [89.523, 12.454], [88.36, 11.887], [87.636, 10.814], [87.546, 9.523], [88.113, 8.36], [89.186, 7.636], [90.477, 7.546], [91.64, 8.113], [92.364, 9.186]];  // corner hole, 12 points
void_5 = [[92.454, 35.477], [91.887, 36.64], [90.814, 37.364], [89.523, 37.454], [88.36, 36.887], [87.636, 35.814], [87.546, 34.523], [88.113, 33.36], [89.186, 32.636], [90.477, 32.546], [91.64, 33.113], [92.364, 34.186]];  // corner hole, 12 points

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
