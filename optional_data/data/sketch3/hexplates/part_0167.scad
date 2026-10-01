$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 6-gon R25, 4 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 6;                // number of polygon sides
plate_r = 25;             // circumscribed radius of the polygon
bore_r = 8;               // centre bore radius
bolts = 4;                // number of bolt windows
ring_r = 16.45;           // bolt-circle radius
bolt_r = 4;               // bolt window radius
plate_t = 6;              // plate thickness, Z (extrusion height)
fit_tol = 0.05;           // declared fit tolerance (prompt contract)
free_tol = 0.3;           // declared free tolerance (prompt contract)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[48.296, 30.619], [30.619, 48.296], [6.47, 41.826], [0, 17.678], [17.678, 0], [41.826, 6.47]];  // primary outline, 6 points, counter clockwise
void_1 = [[31.539, 27.209], [27.209, 31.539], [21.087, 31.539], [16.757, 27.209], [16.757, 21.087], [21.087, 16.757], [27.209, 16.757], [31.539, 21.087]];  // centre bore, 8 points
void_2 = [[43.733, 29.936], [41.568, 32.101], [38.507, 32.101], [36.342, 29.936], [36.342, 26.875], [38.507, 24.71], [41.568, 24.71], [43.733, 26.875]];  // bolt window 1, 8 points
void_3 = [[23.586, 41.568], [21.421, 43.733], [18.36, 43.733], [16.195, 41.568], [16.195, 38.507], [18.36, 36.342], [21.421, 36.342], [23.586, 38.507]];  // bolt window 2, 8 points
void_4 = [[11.954, 21.421], [9.789, 23.586], [6.728, 23.586], [4.563, 21.421], [4.563, 18.36], [6.728, 16.195], [9.789, 16.195], [11.954, 18.36]];  // bolt window 3, 8 points
void_5 = [[32.101, 9.789], [29.936, 11.954], [26.875, 11.954], [24.71, 9.789], [24.71, 6.728], [26.875, 4.563], [29.936, 4.563], [32.101, 6.728]];  // bolt window 4, 8 points

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
