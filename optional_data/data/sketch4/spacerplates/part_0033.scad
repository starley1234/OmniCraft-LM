$fn = 32;

// ----------------------------------------------------------------------
// Spacer plate: rect 90 x 60
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_r = 10;              // centre bore radius
bolt_r = 2.5;             // bolt hole radius
plate_t = 6;              // plate thickness, Z (extrusion height)
plate_l = 90;             // plate length, X
plate_w = 60;             // plate width, Y
inset = 10;               // corner hole inset

profile = [[3, 0], [87, 0], [90, 3], [90, 57], [87, 60], [3, 60], [0, 57], [0, 3]];  // primary outline, 8 points, counter clockwise
void_1 = [[54.816, 31.908], [53.572, 35.15], [51.293, 37.771], [48.256, 39.455], [44.825, 39.998], [41.416, 39.336], [38.439, 37.547], [36.254, 34.848], [35.123, 31.564], [35.184, 28.092], [36.428, 24.85], [38.707, 22.229], [41.744, 20.545], [45.175, 20.002], [48.584, 20.664], [51.561, 22.453], [53.746, 25.152], [54.877, 28.436]];  // centre bore, 18 points
void_2 = [[12.454, 10.477], [11.887, 11.64], [10.814, 12.364], [9.523, 12.454], [8.36, 11.887], [7.636, 10.814], [7.546, 9.523], [8.113, 8.36], [9.186, 7.636], [10.477, 7.546], [11.64, 8.113], [12.364, 9.186]];  // corner hole, 12 points
void_3 = [[12.454, 50.477], [11.887, 51.64], [10.814, 52.364], [9.523, 52.454], [8.36, 51.887], [7.636, 50.814], [7.546, 49.523], [8.113, 48.36], [9.186, 47.636], [10.477, 47.546], [11.64, 48.113], [12.364, 49.186]];  // corner hole, 12 points
void_4 = [[82.454, 10.477], [81.887, 11.64], [80.814, 12.364], [79.523, 12.454], [78.36, 11.887], [77.636, 10.814], [77.546, 9.523], [78.113, 8.36], [79.186, 7.636], [80.477, 7.546], [81.64, 8.113], [82.364, 9.186]];  // corner hole, 12 points
void_5 = [[82.454, 50.477], [81.887, 51.64], [80.814, 52.364], [79.523, 52.454], [78.36, 51.887], [77.636, 50.814], [77.546, 49.523], [78.113, 48.36], [79.186, 47.636], [80.477, 47.546], [81.64, 48.113], [82.364, 49.186]];  // corner hole, 12 points

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
