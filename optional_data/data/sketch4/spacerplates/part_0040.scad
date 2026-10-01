$fn = 32;

// ----------------------------------------------------------------------
// Spacer plate: rect 90 x 45
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_r = 10;              // centre bore radius
bolt_r = 2.5;             // bolt hole radius
plate_t = 6;              // plate thickness, Z (extrusion height)
plate_l = 90;             // plate length, X
plate_w = 45;             // plate width, Y
inset = 10;               // corner hole inset

profile = [[3, 0], [87, 0], [90, 3], [90, 42], [87, 45], [3, 45], [0, 42], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[54.816, 24.408], [53.572, 27.65], [51.293, 30.271], [48.256, 31.955], [44.825, 32.498], [41.416, 31.836], [38.439, 30.047], [36.254, 27.348], [35.123, 24.064], [35.184, 20.592], [36.428, 17.35], [38.707, 14.729], [41.744, 13.045], [45.175, 12.502], [48.584, 13.164], [51.561, 14.953], [53.746, 17.652], [54.877, 20.936]];  // centre bore, 18 points
void_2 = [[12.454, 10.477], [11.887, 11.64], [10.814, 12.364], [9.523, 12.454], [8.36, 11.887], [7.636, 10.814], [7.546, 9.523], [8.113, 8.36], [9.186, 7.636], [10.477, 7.546], [11.64, 8.113], [12.364, 9.186]];  // corner hole, 12 points
void_3 = [[12.454, 35.477], [11.887, 36.64], [10.814, 37.364], [9.523, 37.454], [8.36, 36.887], [7.636, 35.814], [7.546, 34.523], [8.113, 33.36], [9.186, 32.636], [10.477, 32.546], [11.64, 33.113], [12.364, 34.186]];  // corner hole, 12 points
void_4 = [[82.454, 10.477], [81.887, 11.64], [80.814, 12.364], [79.523, 12.454], [78.36, 11.887], [77.636, 10.814], [77.546, 9.523], [78.113, 8.36], [79.186, 7.636], [80.477, 7.546], [81.64, 8.113], [82.364, 9.186]];  // corner hole, 12 points
void_5 = [[82.454, 35.477], [81.887, 36.64], [80.814, 37.364], [79.523, 37.454], [78.36, 36.887], [77.636, 35.814], [77.546, 34.523], [78.113, 33.36], [79.186, 32.636], [80.477, 32.546], [81.64, 33.113], [82.364, 34.186]];  // corner hole, 12 points

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
