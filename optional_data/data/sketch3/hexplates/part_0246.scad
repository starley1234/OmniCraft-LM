$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 8-gon R25, 4 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 8;                // number of polygon sides
plate_r = 25;             // circumscribed radius of the polygon
bore_r = 8;               // centre bore radius
bolts = 4;                // number of bolt windows
ring_r = 15.55;           // bolt-circle radius
bolt_r = 4;               // bolt window radius
plate_t = 6;              // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[49.039, 29.397], [38.409, 45.306], [19.642, 49.039], [3.733, 38.409], [0, 19.642], [10.63, 3.733], [29.397, 0], [45.306, 10.63]];  // primary outline, 8 points, counter clockwise
void_1 = [[31.911, 27.581], [27.581, 31.911], [21.459, 31.911], [17.129, 27.581], [17.129, 21.459], [21.459, 17.129], [27.581, 17.129], [31.911, 21.459]];  // centre bore, 8 points
void_2 = [[43.467, 29.084], [41.302, 31.249], [38.24, 31.249], [36.076, 29.084], [36.076, 26.023], [38.24, 23.858], [41.302, 23.858], [43.467, 26.023]];  // bolt window 1, 8 points
void_3 = [[25.182, 41.302], [23.017, 43.467], [19.956, 43.467], [17.791, 41.302], [17.791, 38.24], [19.956, 36.076], [23.017, 36.076], [25.182, 38.24]];  // bolt window 2, 8 points
void_4 = [[12.964, 23.017], [10.8, 25.182], [7.738, 25.182], [5.573, 23.017], [5.573, 19.956], [7.738, 17.791], [10.8, 17.791], [12.964, 19.956]];  // bolt window 3, 8 points
void_5 = [[31.249, 10.8], [29.084, 12.964], [26.023, 12.964], [23.858, 10.8], [23.858, 7.738], [26.023, 5.573], [29.084, 5.573], [31.249, 7.738]];  // bolt window 4, 8 points

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
