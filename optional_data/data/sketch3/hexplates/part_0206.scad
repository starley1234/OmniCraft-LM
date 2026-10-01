$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 8-gon R40, 3 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 8;                // number of polygon sides
plate_r = 40;             // circumscribed radius of the polygon
bore_r = 10;              // centre bore radius
bolts = 3;                // number of bolt windows
ring_r = 23.48;           // bolt-circle radius
bolt_r = 2.5;             // bolt window radius
plate_t = 8;              // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[80, 40], [68.284, 68.284], [40, 80], [11.716, 68.284], [0, 40], [11.716, 11.716], [40, 0], [68.284, 11.716]];  // primary outline, 8 points, counter clockwise
void_1 = [[49.239, 43.827], [43.827, 49.239], [36.173, 49.239], [30.761, 43.827], [30.761, 36.173], [36.173, 30.761], [43.827, 30.761], [49.239, 36.173]];  // centre bore, 8 points
void_2 = [[65.79, 40.957], [64.437, 42.31], [62.523, 42.31], [61.17, 40.957], [61.17, 39.043], [62.523, 37.69], [64.437, 37.69], [65.79, 39.043]];  // bolt window 1, 8 points
void_3 = [[30.57, 61.291], [29.217, 62.644], [27.303, 62.644], [25.95, 61.291], [25.95, 59.378], [27.303, 58.025], [29.217, 58.025], [30.57, 59.378]];  // bolt window 2, 8 points
void_4 = [[30.57, 20.622], [29.217, 21.975], [27.303, 21.975], [25.95, 20.622], [25.95, 18.709], [27.303, 17.356], [29.217, 17.356], [30.57, 18.709]];  // bolt window 3, 8 points

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
}
