$fn = 32;

// ----------------------------------------------------------------------
// Spacer plate: rect 80 x 50
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_r = 8;               // centre bore radius
bolt_r = 2.5;             // bolt hole radius
plate_t = 8;              // plate thickness, Z (extrusion height)
plate_l = 80;             // plate length, X
plate_w = 50;             // plate width, Y
inset = 10;               // corner hole inset

profile = [[3, 0], [77, 0], [80, 3], [80, 47], [77, 50], [3, 50], [0, 47], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[47.853, 26.526], [46.857, 29.12], [45.035, 31.217], [42.605, 32.564], [39.86, 32.999], [37.133, 32.469], [34.752, 31.038], [33.003, 28.878], [32.098, 26.251], [32.147, 23.474], [33.143, 20.88], [34.965, 18.783], [37.395, 17.436], [40.14, 17.001], [42.867, 17.531], [45.248, 18.962], [46.997, 21.122], [47.902, 23.749]];  // centre bore, 18 points
void_2 = [[12.454, 10.477], [11.887, 11.64], [10.814, 12.364], [9.523, 12.454], [8.36, 11.887], [7.636, 10.814], [7.546, 9.523], [8.113, 8.36], [9.186, 7.636], [10.477, 7.546], [11.64, 8.113], [12.364, 9.186]];  // corner hole, 12 points
void_3 = [[12.454, 40.477], [11.887, 41.64], [10.814, 42.364], [9.523, 42.454], [8.36, 41.887], [7.636, 40.814], [7.546, 39.523], [8.113, 38.36], [9.186, 37.636], [10.477, 37.546], [11.64, 38.113], [12.364, 39.186]];  // corner hole, 12 points
void_4 = [[72.454, 10.477], [71.887, 11.64], [70.814, 12.364], [69.523, 12.454], [68.36, 11.887], [67.636, 10.814], [67.546, 9.523], [68.113, 8.36], [69.186, 7.636], [70.477, 7.546], [71.64, 8.113], [72.364, 9.186]];  // corner hole, 12 points
void_5 = [[72.454, 40.477], [71.887, 41.64], [70.814, 42.364], [69.523, 42.454], [68.36, 41.887], [67.636, 40.814], [67.546, 39.523], [68.113, 38.36], [69.186, 37.636], [70.477, 37.546], [71.64, 38.113], [72.364, 39.186]];  // corner hole, 12 points

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
