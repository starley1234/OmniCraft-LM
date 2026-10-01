$fn = 32;

// ----------------------------------------------------------------------
// Spacer plate: rect 80 x 45
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_r = 12;              // centre bore radius
bolt_r = 2.5;             // bolt hole radius
plate_t = 8;              // plate thickness, Z (extrusion height)
plate_l = 80;             // plate length, X
plate_w = 45;             // plate width, Y
inset = 10;               // corner hole inset

profile = [[3, 0], [77, 0], [80, 3], [80, 42], [77, 45], [3, 45], [0, 42], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[51.78, 24.79], [50.286, 28.68], [47.552, 31.826], [43.907, 33.846], [39.791, 34.498], [35.7, 33.703], [32.127, 31.557], [29.505, 28.318], [28.148, 24.377], [28.22, 20.21], [29.714, 16.32], [32.448, 13.174], [36.093, 11.154], [40.209, 10.502], [44.3, 11.297], [47.873, 13.443], [50.495, 16.682], [51.852, 20.623]];  // centre bore, 18 points
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
