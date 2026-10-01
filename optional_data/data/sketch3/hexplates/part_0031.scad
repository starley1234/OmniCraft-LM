$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 6-gon R30, 4 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 6;                // number of polygon sides
plate_r = 30;             // circumscribed radius of the polygon
bore_r = 10;              // centre bore radius
bolts = 4;                // number of bolt windows
ring_r = 22.28;           // bolt-circle radius
bolt_r = 2.5;             // bolt window radius
plate_t = 8;              // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[57.956, 36.742], [36.742, 57.956], [7.765, 50.191], [0, 21.213], [21.213, 0], [50.191, 7.765]];  // primary outline, 6 points, counter clockwise
void_1 = [[38.217, 32.805], [32.805, 38.217], [25.151, 38.217], [19.739, 32.805], [19.739, 25.151], [25.151, 19.739], [32.805, 19.739], [38.217, 25.151]];  // centre bore, 8 points
void_2 = [[52.809, 35.701], [51.456, 37.054], [49.542, 37.054], [48.189, 35.701], [48.189, 33.788], [49.542, 32.435], [51.456, 32.435], [52.809, 33.788]];  // bolt window 1, 8 points
void_3 = [[25.521, 51.456], [24.168, 52.809], [22.255, 52.809], [20.902, 51.456], [20.902, 49.542], [22.255, 48.189], [24.168, 48.189], [25.521, 49.542]];  // bolt window 2, 8 points
void_4 = [[9.767, 24.168], [8.414, 25.521], [6.5, 25.521], [5.147, 24.168], [5.147, 22.255], [6.5, 20.902], [8.414, 20.902], [9.767, 22.255]];  // bolt window 3, 8 points
void_5 = [[37.054, 8.414], [35.701, 9.767], [33.788, 9.767], [32.435, 8.414], [32.435, 6.5], [33.788, 5.147], [35.701, 5.147], [37.054, 6.5]];  // bolt window 4, 8 points

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
