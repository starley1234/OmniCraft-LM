$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 6-gon R30, 6 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 6;                // number of polygon sides
plate_r = 30;             // circumscribed radius of the polygon
bore_r = 8;               // centre bore radius
bolts = 6;                // number of bolt windows
ring_r = 22.28;           // bolt-circle radius
bolt_r = 2.5;             // bolt window radius
plate_t = 8;              // plate thickness, Z (extrusion height)
fit_tol = 0.1;            // declared fit tolerance (prompt contract)
free_tol = 0.5;           // declared free tolerance (prompt contract)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[57.956, 36.742], [36.742, 57.956], [7.765, 50.191], [0, 21.213], [21.213, 0], [50.191, 7.765]];  // primary outline, 6 points, counter clockwise
void_1 = [[36.369, 32.039], [32.039, 36.369], [25.917, 36.369], [21.587, 32.039], [21.587, 25.917], [25.917, 21.587], [32.039, 21.587], [36.369, 25.917]];  // centre bore, 8 points
void_2 = [[52.809, 35.701], [51.456, 37.054], [49.542, 37.054], [48.189, 35.701], [48.189, 33.788], [49.542, 32.435], [51.456, 32.435], [52.809, 33.788]];  // bolt window 1, 8 points
void_3 = [[37.054, 51.456], [35.701, 52.809], [33.788, 52.809], [32.435, 51.456], [32.435, 49.542], [33.788, 48.189], [35.701, 48.189], [37.054, 49.542]];  // bolt window 2, 8 points
void_4 = [[15.533, 45.689], [14.18, 47.042], [12.267, 47.042], [10.914, 45.689], [10.914, 43.776], [12.267, 42.423], [14.18, 42.423], [15.533, 43.776]];  // bolt window 3, 8 points
void_5 = [[9.767, 24.168], [8.414, 25.521], [6.5, 25.521], [5.147, 24.168], [5.147, 22.255], [6.5, 20.902], [8.414, 20.902], [9.767, 22.255]];  // bolt window 4, 8 points
void_6 = [[25.521, 8.414], [24.168, 9.767], [22.255, 9.767], [20.902, 8.414], [20.902, 6.5], [22.255, 5.147], [24.168, 5.147], [25.521, 6.5]];  // bolt window 5, 8 points
void_7 = [[47.042, 14.18], [45.689, 15.533], [43.776, 15.533], [42.423, 14.18], [42.423, 12.267], [43.776, 10.914], [45.689, 10.914], [47.042, 12.267]];  // bolt window 6, 8 points

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
