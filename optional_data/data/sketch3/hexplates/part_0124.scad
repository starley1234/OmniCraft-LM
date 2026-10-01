$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 6-gon R25, 4 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 6;                // number of polygon sides
plate_r = 25;             // circumscribed radius of the polygon
bore_r = 8;               // centre bore radius
bolts = 4;                // number of bolt windows
ring_r = 17.95;           // bolt-circle radius
bolt_r = 2.5;             // bolt window radius
plate_t = 6;              // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[48.296, 30.619], [30.619, 48.296], [6.47, 41.826], [0, 17.678], [17.678, 0], [41.826, 6.47]];  // primary outline, 6 points, counter clockwise
void_1 = [[31.539, 27.209], [27.209, 31.539], [21.087, 31.539], [16.757, 27.209], [16.757, 21.087], [21.087, 16.757], [27.209, 16.757], [31.539, 21.087]];  // centre bore, 8 points
void_2 = [[43.796, 29.751], [42.443, 31.104], [40.53, 31.104], [39.177, 29.751], [39.177, 27.837], [40.53, 26.484], [42.443, 26.484], [43.796, 27.837]];  // bolt window 1, 8 points
void_3 = [[21.812, 42.443], [20.459, 43.796], [18.545, 43.796], [17.192, 42.443], [17.192, 40.53], [18.545, 39.177], [20.459, 39.177], [21.812, 40.53]];  // bolt window 2, 8 points
void_4 = [[9.119, 20.459], [7.766, 21.812], [5.853, 21.812], [4.5, 20.459], [4.5, 18.545], [5.853, 17.192], [7.766, 17.192], [9.119, 18.545]];  // bolt window 3, 8 points
void_5 = [[31.104, 7.766], [29.751, 9.119], [27.837, 9.119], [26.484, 7.766], [26.484, 5.853], [27.837, 4.5], [29.751, 4.5], [31.104, 5.853]];  // bolt window 4, 8 points

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
