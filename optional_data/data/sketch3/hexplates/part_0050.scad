$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 6-gon R35, 4 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 6;                // number of polygon sides
plate_r = 35;             // circumscribed radius of the polygon
bore_r = 6;               // centre bore radius
bolts = 4;                // number of bolt windows
ring_r = 25.11;           // bolt-circle radius
bolt_r = 4;               // bolt window radius
plate_t = 6;              // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[67.615, 42.866], [42.866, 67.615], [9.059, 58.556], [0, 24.749], [24.749, 0], [58.556, 9.059]];  // primary outline, 6 points, counter clockwise
void_1 = [[39.35, 36.103], [36.103, 39.35], [31.511, 39.35], [28.264, 36.103], [28.264, 31.511], [31.511, 28.264], [36.103, 28.264], [39.35, 31.511]];  // centre bore, 8 points
void_2 = [[61.757, 41.837], [59.592, 44.001], [56.531, 44.001], [54.366, 41.837], [54.366, 38.775], [56.531, 36.61], [59.592, 36.61], [61.757, 38.775]];  // bolt window 1, 8 points
void_3 = [[31.004, 59.592], [28.839, 61.757], [25.777, 61.757], [23.613, 59.592], [23.613, 56.531], [25.777, 54.366], [28.839, 54.366], [31.004, 56.531]];  // bolt window 2, 8 points
void_4 = [[13.248, 28.839], [11.083, 31.004], [8.022, 31.004], [5.857, 28.839], [5.857, 25.777], [8.022, 23.613], [11.083, 23.613], [13.248, 25.777]];  // bolt window 3, 8 points
void_5 = [[44.001, 11.083], [41.837, 13.248], [38.775, 13.248], [36.61, 11.083], [36.61, 8.022], [38.775, 5.857], [41.837, 5.857], [44.001, 8.022]];  // bolt window 4, 8 points

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
