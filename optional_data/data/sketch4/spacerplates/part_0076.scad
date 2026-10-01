$fn = 32;

// ----------------------------------------------------------------------
// Spacer plate: rect 80 x 60
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_r = 8;               // centre bore radius
bolt_r = 2.5;             // bolt hole radius
plate_t = 5;              // plate thickness, Z (extrusion height)
plate_l = 80;             // plate length, X
plate_w = 60;             // plate width, Y
inset = 10;               // corner hole inset

profile = [[3, 0], [77, 0], [80, 3], [80, 57], [77, 60], [3, 60], [0, 57], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[47.853, 31.526], [46.857, 34.12], [45.035, 36.217], [42.605, 37.564], [39.86, 37.999], [37.133, 37.469], [34.752, 36.038], [33.003, 33.878], [32.098, 31.251], [32.147, 28.474], [33.143, 25.88], [34.965, 23.783], [37.395, 22.436], [40.14, 22.001], [42.867, 22.531], [45.248, 23.962], [46.997, 26.122], [47.902, 28.749]];  // centre bore, 18 points
void_2 = [[12.454, 10.477], [11.887, 11.64], [10.814, 12.364], [9.523, 12.454], [8.36, 11.887], [7.636, 10.814], [7.546, 9.523], [8.113, 8.36], [9.186, 7.636], [10.477, 7.546], [11.64, 8.113], [12.364, 9.186]];  // corner hole, 12 points
void_3 = [[12.454, 50.477], [11.887, 51.64], [10.814, 52.364], [9.523, 52.454], [8.36, 51.887], [7.636, 50.814], [7.546, 49.523], [8.113, 48.36], [9.186, 47.636], [10.477, 47.546], [11.64, 48.113], [12.364, 49.186]];  // corner hole, 12 points
void_4 = [[72.454, 10.477], [71.887, 11.64], [70.814, 12.364], [69.523, 12.454], [68.36, 11.887], [67.636, 10.814], [67.546, 9.523], [68.113, 8.36], [69.186, 7.636], [70.477, 7.546], [71.64, 8.113], [72.364, 9.186]];  // corner hole, 12 points
void_5 = [[72.454, 50.477], [71.887, 51.64], [70.814, 52.364], [69.523, 52.454], [68.36, 51.887], [67.636, 50.814], [67.546, 49.523], [68.113, 48.36], [69.186, 47.636], [70.477, 47.546], [71.64, 48.113], [72.364, 49.186]];  // corner hole, 12 points

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
