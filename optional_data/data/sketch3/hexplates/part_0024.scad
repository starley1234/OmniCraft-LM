$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 6-gon R30, 6 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 6;                // number of polygon sides
plate_r = 30;             // circumscribed radius of the polygon
bore_r = 10;              // centre bore radius
bolts = 6;                // number of bolt windows
ring_r = 21.78;           // bolt-circle radius
bolt_r = 3;               // bolt window radius
plate_t = 5;              // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[60, 25.981], [45, 51.962], [15, 51.962], [0, 25.981], [15, 0], [45, 0]];  // primary outline, 6 points, counter clockwise
void_1 = [[39.239, 29.808], [33.827, 35.22], [26.173, 35.22], [20.761, 29.808], [20.761, 22.154], [26.173, 16.742], [33.827, 16.742], [39.239, 22.154]];  // centre bore, 8 points
void_2 = [[54.552, 27.129], [52.928, 28.753], [50.632, 28.753], [49.008, 27.129], [49.008, 24.833], [50.632, 23.209], [52.928, 23.209], [54.552, 24.833]];  // bolt window 1, 8 points
void_3 = [[43.662, 45.991], [42.038, 47.615], [39.742, 47.615], [38.118, 45.991], [38.118, 43.695], [39.742, 42.071], [42.038, 42.071], [43.662, 43.695]];  // bolt window 2, 8 points
void_4 = [[21.882, 45.991], [20.258, 47.615], [17.962, 47.615], [16.338, 45.991], [16.338, 43.695], [17.962, 42.071], [20.258, 42.071], [21.882, 43.695]];  // bolt window 3, 8 points
void_5 = [[10.992, 27.129], [9.368, 28.753], [7.072, 28.753], [5.448, 27.129], [5.448, 24.833], [7.072, 23.209], [9.368, 23.209], [10.992, 24.833]];  // bolt window 4, 8 points
void_6 = [[21.882, 8.267], [20.258, 9.891], [17.962, 9.891], [16.338, 8.267], [16.338, 5.971], [17.962, 4.347], [20.258, 4.347], [21.882, 5.971]];  // bolt window 5, 8 points
void_7 = [[43.662, 8.267], [42.038, 9.891], [39.742, 9.891], [38.118, 8.267], [38.118, 5.971], [39.742, 4.347], [42.038, 4.347], [43.662, 5.971]];  // bolt window 6, 8 points

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
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_6);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_7);
}
