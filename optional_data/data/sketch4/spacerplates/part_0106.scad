$fn = 32;

// ----------------------------------------------------------------------
// Spacer plate: rect 80 x 45
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_r = 8;               // centre bore radius
bolt_r = 2.5;             // bolt hole radius
plate_t = 5;              // plate thickness, Z (extrusion height)
plate_l = 80;             // plate length, X
plate_w = 45;             // plate width, Y
inset = 12;               // corner hole inset
fit_tol = 0.02;           // declared fit tolerance (prompt contract)
free_tol = 0.2;           // declared free tolerance (prompt contract)

profile = [[3, 0], [77, 0], [80, 3], [80, 42], [77, 45], [3, 45], [0, 42], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[47.853, 24.026], [46.857, 26.62], [45.035, 28.717], [42.605, 30.064], [39.86, 30.499], [37.133, 29.969], [34.752, 28.538], [33.003, 26.378], [32.098, 23.751], [32.147, 20.974], [33.143, 18.38], [34.965, 16.283], [37.395, 14.936], [40.14, 14.501], [42.867, 15.031], [45.248, 16.462], [46.997, 18.622], [47.902, 21.249]];  // centre bore, 18 points
void_2 = [[14.454, 12.477], [13.887, 13.64], [12.814, 14.364], [11.523, 14.454], [10.36, 13.887], [9.636, 12.814], [9.546, 11.523], [10.113, 10.36], [11.186, 9.636], [12.477, 9.546], [13.64, 10.113], [14.364, 11.186]];  // corner hole, 12 points
void_3 = [[14.454, 33.477], [13.887, 34.64], [12.814, 35.364], [11.523, 35.454], [10.36, 34.887], [9.636, 33.814], [9.546, 32.523], [10.113, 31.36], [11.186, 30.636], [12.477, 30.546], [13.64, 31.113], [14.364, 32.186]];  // corner hole, 12 points
void_4 = [[70.454, 12.477], [69.887, 13.64], [68.814, 14.364], [67.523, 14.454], [66.36, 13.887], [65.636, 12.814], [65.546, 11.523], [66.113, 10.36], [67.186, 9.636], [68.477, 9.546], [69.64, 10.113], [70.364, 11.186]];  // corner hole, 12 points
void_5 = [[70.454, 33.477], [69.887, 34.64], [68.814, 35.364], [67.523, 35.454], [66.36, 34.887], [65.636, 33.814], [65.546, 32.523], [66.113, 31.36], [67.186, 30.636], [68.477, 30.546], [69.64, 31.113], [70.364, 32.186]];  // corner hole, 12 points

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
