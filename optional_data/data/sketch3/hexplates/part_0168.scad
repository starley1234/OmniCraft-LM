$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 8-gon R25, 6 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 8;                // number of polygon sides
plate_r = 25;             // circumscribed radius of the polygon
bore_r = 10;              // centre bore radius
bolts = 6;                // number of bolt windows
ring_r = 16.55;           // bolt-circle radius
bolt_r = 3;               // bolt window radius
plate_t = 5;              // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[50, 25], [42.678, 42.678], [25, 50], [7.322, 42.678], [0, 25], [7.322, 7.322], [25, 0], [42.678, 7.322]];  // primary outline, 8 points, counter clockwise
void_1 = [[34.239, 28.827], [28.827, 34.239], [21.173, 34.239], [15.761, 28.827], [15.761, 21.173], [21.173, 15.761], [28.827, 15.761], [34.239, 21.173]];  // centre bore, 8 points
void_2 = [[44.322, 26.148], [42.698, 27.772], [40.402, 27.772], [38.778, 26.148], [38.778, 23.852], [40.402, 22.228], [42.698, 22.228], [44.322, 23.852]];  // bolt window 1, 8 points
void_3 = [[36.047, 40.481], [34.423, 42.104], [32.127, 42.104], [30.503, 40.481], [30.503, 38.185], [32.127, 36.561], [34.423, 36.561], [36.047, 38.185]];  // bolt window 2, 8 points
void_4 = [[19.497, 40.481], [17.873, 42.104], [15.577, 42.104], [13.953, 40.481], [13.953, 38.185], [15.577, 36.561], [17.873, 36.561], [19.497, 38.185]];  // bolt window 3, 8 points
void_5 = [[11.222, 26.148], [9.598, 27.772], [7.302, 27.772], [5.678, 26.148], [5.678, 23.852], [7.302, 22.228], [9.598, 22.228], [11.222, 23.852]];  // bolt window 4, 8 points
void_6 = [[19.497, 11.815], [17.873, 13.439], [15.577, 13.439], [13.953, 11.815], [13.953, 9.519], [15.577, 7.896], [17.873, 7.896], [19.497, 9.519]];  // bolt window 5, 8 points
void_7 = [[36.047, 11.815], [34.423, 13.439], [32.127, 13.439], [30.503, 11.815], [30.503, 9.519], [32.127, 7.896], [34.423, 7.896], [36.047, 9.519]];  // bolt window 6, 8 points

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
