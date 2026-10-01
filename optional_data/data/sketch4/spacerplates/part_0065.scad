$fn = 32;

// ----------------------------------------------------------------------
// Spacer plate: rect 90 x 50
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_r = 8;               // centre bore radius
bolt_r = 2.5;             // bolt hole radius
plate_t = 5;              // plate thickness, Z (extrusion height)
plate_l = 90;             // plate length, X
plate_w = 50;             // plate width, Y
inset = 12;               // corner hole inset
fit_tol = 0.02;           // declared fit tolerance (prompt contract)
free_tol = 0.2;           // declared free tolerance (prompt contract)

profile = [[3, 0], [87, 0], [90, 3], [90, 47], [87, 50], [3, 50], [0, 47], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[52.853, 26.526], [51.857, 29.12], [50.035, 31.217], [47.605, 32.564], [44.86, 32.999], [42.133, 32.469], [39.752, 31.038], [38.003, 28.878], [37.098, 26.251], [37.147, 23.474], [38.143, 20.88], [39.965, 18.783], [42.395, 17.436], [45.14, 17.001], [47.867, 17.531], [50.248, 18.962], [51.997, 21.122], [52.902, 23.749]];  // centre bore, 18 points
void_2 = [[14.454, 12.477], [13.887, 13.64], [12.814, 14.364], [11.523, 14.454], [10.36, 13.887], [9.636, 12.814], [9.546, 11.523], [10.113, 10.36], [11.186, 9.636], [12.477, 9.546], [13.64, 10.113], [14.364, 11.186]];  // corner hole, 12 points
void_3 = [[14.454, 38.477], [13.887, 39.64], [12.814, 40.364], [11.523, 40.454], [10.36, 39.887], [9.636, 38.814], [9.546, 37.523], [10.113, 36.36], [11.186, 35.636], [12.477, 35.546], [13.64, 36.113], [14.364, 37.186]];  // corner hole, 12 points
void_4 = [[80.454, 12.477], [79.887, 13.64], [78.814, 14.364], [77.523, 14.454], [76.36, 13.887], [75.636, 12.814], [75.546, 11.523], [76.113, 10.36], [77.186, 9.636], [78.477, 9.546], [79.64, 10.113], [80.364, 11.186]];  // corner hole, 12 points
void_5 = [[80.454, 38.477], [79.887, 39.64], [78.814, 40.364], [77.523, 40.454], [76.36, 39.887], [75.636, 38.814], [75.546, 37.523], [76.113, 36.36], [77.186, 35.636], [78.477, 35.546], [79.64, 36.113], [80.364, 37.186]];  // corner hole, 12 points

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
