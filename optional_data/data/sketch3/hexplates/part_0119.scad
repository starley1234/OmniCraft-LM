$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 6-gon R25, 6 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 6;                // number of polygon sides
plate_r = 25;             // circumscribed radius of the polygon
bore_r = 8;               // centre bore radius
bolts = 6;                // number of bolt windows
ring_r = 16.45;           // bolt-circle radius
bolt_r = 4;               // bolt window radius
plate_t = 10;             // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[48.296, 30.619], [30.619, 48.296], [6.47, 41.826], [0, 17.678], [17.678, 0], [41.826, 6.47]];  // primary outline, 6 points, counter clockwise
void_1 = [[31.539, 27.209], [27.209, 31.539], [21.087, 31.539], [16.757, 27.209], [16.757, 21.087], [21.087, 16.757], [27.209, 16.757], [31.539, 21.087]];  // centre bore, 8 points
void_2 = [[43.733, 29.936], [41.568, 32.101], [38.507, 32.101], [36.342, 29.936], [36.342, 26.875], [38.507, 24.71], [41.568, 24.71], [43.733, 26.875]];  // bolt window 1, 8 points
void_3 = [[32.101, 41.568], [29.936, 43.733], [26.875, 43.733], [24.71, 41.568], [24.71, 38.507], [26.875, 36.342], [29.936, 36.342], [32.101, 38.507]];  // bolt window 2, 8 points
void_4 = [[16.212, 37.311], [14.047, 39.475], [10.985, 39.475], [8.821, 37.311], [8.821, 34.249], [10.985, 32.084], [14.047, 32.084], [16.212, 34.249]];  // bolt window 3, 8 points
void_5 = [[11.954, 21.421], [9.789, 23.586], [6.728, 23.586], [4.563, 21.421], [4.563, 18.36], [6.728, 16.195], [9.789, 16.195], [11.954, 18.36]];  // bolt window 4, 8 points
void_6 = [[23.586, 9.789], [21.421, 11.954], [18.36, 11.954], [16.195, 9.789], [16.195, 6.728], [18.36, 4.563], [21.421, 4.563], [23.586, 6.728]];  // bolt window 5, 8 points
void_7 = [[39.475, 14.047], [37.311, 16.212], [34.249, 16.212], [32.084, 14.047], [32.084, 10.985], [34.249, 8.821], [37.311, 8.821], [39.475, 10.985]];  // bolt window 6, 8 points

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
