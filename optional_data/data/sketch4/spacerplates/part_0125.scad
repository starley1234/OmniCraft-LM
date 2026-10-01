$fn = 32;

// ----------------------------------------------------------------------
// Spacer plate: rect 80 x 45
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_r = 8;               // centre bore radius
bolt_r = 2.5;             // bolt hole radius
plate_t = 6;              // plate thickness, Z (extrusion height)
plate_l = 80;             // plate length, X
plate_w = 45;             // plate width, Y
inset = 10;               // corner hole inset

profile = [[3, 0], [77, 0], [80, 3], [80, 42], [77, 45], [3, 45], [0, 42], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[47.853, 24.026], [46.857, 26.62], [45.035, 28.717], [42.605, 30.064], [39.86, 30.499], [37.133, 29.969], [34.752, 28.538], [33.003, 26.378], [32.098, 23.751], [32.147, 20.974], [33.143, 18.38], [34.965, 16.283], [37.395, 14.936], [40.14, 14.501], [42.867, 15.031], [45.248, 16.462], [46.997, 18.622], [47.902, 21.249]];  // centre bore, 18 points
void_2 = [[12.454, 10.477], [11.887, 11.64], [10.814, 12.364], [9.523, 12.454], [8.36, 11.887], [7.636, 10.814], [7.546, 9.523], [8.113, 8.36], [9.186, 7.636], [10.477, 7.546], [11.64, 8.113], [12.364, 9.186]];  // corner hole, 12 points
void_3 = [[12.454, 35.477], [11.887, 36.64], [10.814, 37.364], [9.523, 37.454], [8.36, 36.887], [7.636, 35.814], [7.546, 34.523], [8.113, 33.36], [9.186, 32.636], [10.477, 32.546], [11.64, 33.113], [12.364, 34.186]];  // corner hole, 12 points
void_4 = [[72.454, 10.477], [71.887, 11.64], [70.814, 12.364], [69.523, 12.454], [68.36, 11.887], [67.636, 10.814], [67.546, 9.523], [68.113, 8.36], [69.186, 7.636], [70.477, 7.546], [71.64, 8.113], [72.364, 9.186]];  // corner hole, 12 points
void_5 = [[72.454, 35.477], [71.887, 36.64], [70.814, 37.364], [69.523, 37.454], [68.36, 36.887], [67.636, 35.814], [67.546, 34.523], [68.113, 33.36], [69.186, 32.636], [70.477, 32.546], [71.64, 33.113], [72.364, 34.186]];  // corner hole, 12 points

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
