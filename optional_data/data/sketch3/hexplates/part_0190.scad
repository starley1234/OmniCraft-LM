$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 8-gon R25, 6 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 8;                // number of polygon sides
plate_r = 25;             // circumscribed radius of the polygon
bore_r = 8;               // centre bore radius
bolts = 6;                // number of bolt windows
ring_r = 15.55;           // bolt-circle radius
bolt_r = 3;               // bolt window radius
plate_t = 6;              // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[50, 25], [42.678, 42.678], [25, 50], [7.322, 42.678], [0, 25], [7.322, 7.322], [25, 0], [42.678, 7.322]];  // primary outline, 8 points, counter clockwise
void_1 = [[32.391, 28.061], [28.061, 32.391], [21.939, 32.391], [17.609, 28.061], [17.609, 21.939], [21.939, 17.609], [28.061, 17.609], [32.391, 21.939]];  // centre bore, 8 points
void_2 = [[43.322, 26.148], [41.698, 27.772], [39.402, 27.772], [37.778, 26.148], [37.778, 23.852], [39.402, 22.228], [41.698, 22.228], [43.322, 23.852]];  // bolt window 1, 8 points
void_3 = [[35.547, 39.615], [33.923, 41.238], [31.627, 41.238], [30.003, 39.615], [30.003, 37.319], [31.627, 35.695], [33.923, 35.695], [35.547, 37.319]];  // bolt window 2, 8 points
void_4 = [[19.997, 39.615], [18.373, 41.238], [16.077, 41.238], [14.453, 39.615], [14.453, 37.319], [16.077, 35.695], [18.373, 35.695], [19.997, 37.319]];  // bolt window 3, 8 points
void_5 = [[12.222, 26.148], [10.598, 27.772], [8.302, 27.772], [6.678, 26.148], [6.678, 23.852], [8.302, 22.228], [10.598, 22.228], [12.222, 23.852]];  // bolt window 4, 8 points
void_6 = [[19.997, 12.681], [18.373, 14.305], [16.077, 14.305], [14.453, 12.681], [14.453, 10.385], [16.077, 8.762], [18.373, 8.762], [19.997, 10.385]];  // bolt window 5, 8 points
void_7 = [[35.547, 12.681], [33.923, 14.305], [31.627, 14.305], [30.003, 12.681], [30.003, 10.385], [31.627, 8.762], [33.923, 8.762], [35.547, 10.385]];  // bolt window 6, 8 points

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
