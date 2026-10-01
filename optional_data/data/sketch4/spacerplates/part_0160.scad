$fn = 32;

// ----------------------------------------------------------------------
// Spacer plate: rect 80 x 45
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_r = 12;              // centre bore radius
bolt_r = 3;               // bolt hole radius
plate_t = 8;              // plate thickness, Z (extrusion height)
plate_l = 80;             // plate length, X
plate_w = 45;             // plate width, Y
inset = 10;               // corner hole inset

profile = [[3, 0], [77, 0], [80, 3], [80, 42], [77, 45], [3, 45], [0, 42], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[51.78, 24.79], [50.286, 28.68], [47.552, 31.826], [43.907, 33.846], [39.791, 34.498], [35.7, 33.703], [32.127, 31.557], [29.505, 28.318], [28.148, 24.377], [28.22, 20.21], [29.714, 16.32], [32.448, 13.174], [36.093, 11.154], [40.209, 10.502], [44.3, 11.297], [47.873, 13.443], [50.495, 16.682], [51.852, 20.623]];  // centre bore, 18 points
void_2 = [[12.945, 10.572], [12.264, 11.968], [10.977, 12.837], [9.428, 12.945], [8.032, 12.264], [7.163, 10.977], [7.055, 9.428], [7.736, 8.032], [9.023, 7.163], [10.572, 7.055], [11.968, 7.736], [12.837, 9.023]];  // corner hole, 12 points
void_3 = [[12.945, 35.572], [12.264, 36.968], [10.977, 37.837], [9.428, 37.945], [8.032, 37.264], [7.163, 35.977], [7.055, 34.428], [7.736, 33.032], [9.023, 32.163], [10.572, 32.055], [11.968, 32.736], [12.837, 34.023]];  // corner hole, 12 points
void_4 = [[72.945, 10.572], [72.264, 11.968], [70.977, 12.837], [69.428, 12.945], [68.032, 12.264], [67.163, 10.977], [67.055, 9.428], [67.736, 8.032], [69.023, 7.163], [70.572, 7.055], [71.968, 7.736], [72.837, 9.023]];  // corner hole, 12 points
void_5 = [[72.945, 35.572], [72.264, 36.968], [70.977, 37.837], [69.428, 37.945], [68.032, 37.264], [67.163, 35.977], [67.055, 34.428], [67.736, 33.032], [69.023, 32.163], [70.572, 32.055], [71.968, 32.736], [72.837, 34.023]];  // corner hole, 12 points

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
