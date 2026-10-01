$fn = 32;

// ----------------------------------------------------------------------
// Spacer plate: rect 70 x 60
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_r = 10;              // centre bore radius
bolt_r = 2.5;             // bolt hole radius
plate_t = 8;              // plate thickness, Z (extrusion height)
plate_l = 70;             // plate length, X
plate_w = 60;             // plate width, Y
inset = 10;               // corner hole inset

profile = [[3, 0], [67, 0], [70, 3], [70, 57], [67, 60], [3, 60], [0, 57], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[44.816, 31.908], [43.572, 35.15], [41.293, 37.771], [38.256, 39.455], [34.825, 39.998], [31.416, 39.336], [28.439, 37.547], [26.254, 34.848], [25.123, 31.564], [25.184, 28.092], [26.428, 24.85], [28.707, 22.229], [31.744, 20.545], [35.175, 20.002], [38.584, 20.664], [41.561, 22.453], [43.746, 25.152], [44.877, 28.436]];  // centre bore, 18 points
void_2 = [[12.454, 10.477], [11.887, 11.64], [10.814, 12.364], [9.523, 12.454], [8.36, 11.887], [7.636, 10.814], [7.546, 9.523], [8.113, 8.36], [9.186, 7.636], [10.477, 7.546], [11.64, 8.113], [12.364, 9.186]];  // corner hole, 12 points
void_3 = [[12.454, 50.477], [11.887, 51.64], [10.814, 52.364], [9.523, 52.454], [8.36, 51.887], [7.636, 50.814], [7.546, 49.523], [8.113, 48.36], [9.186, 47.636], [10.477, 47.546], [11.64, 48.113], [12.364, 49.186]];  // corner hole, 12 points
void_4 = [[62.454, 10.477], [61.887, 11.64], [60.814, 12.364], [59.523, 12.454], [58.36, 11.887], [57.636, 10.814], [57.546, 9.523], [58.113, 8.36], [59.186, 7.636], [60.477, 7.546], [61.64, 8.113], [62.364, 9.186]];  // corner hole, 12 points
void_5 = [[62.454, 50.477], [61.887, 51.64], [60.814, 52.364], [59.523, 52.454], [58.36, 51.887], [57.636, 50.814], [57.546, 49.523], [58.113, 48.36], [59.186, 47.636], [60.477, 47.546], [61.64, 48.113], [62.364, 49.186]];  // corner hole, 12 points

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
