$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 8-gon R40, 4 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 8;                // number of polygon sides
plate_r = 40;             // circumscribed radius of the polygon
bore_r = 10;              // centre bore radius
bolts = 4;                // number of bolt windows
ring_r = 23.48;           // bolt-circle radius
bolt_r = 2.5;             // bolt window radius
plate_t = 5;              // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[80, 40], [68.284, 68.284], [40, 80], [11.716, 68.284], [0, 40], [11.716, 11.716], [40, 0], [68.284, 11.716]];  // primary outline, 8 points, counter clockwise
void_1 = [[49.239, 43.827], [43.827, 49.239], [36.173, 49.239], [30.761, 43.827], [30.761, 36.173], [36.173, 30.761], [43.827, 30.761], [49.239, 36.173]];  // centre bore, 8 points
void_2 = [[65.79, 40.957], [64.437, 42.31], [62.523, 42.31], [61.17, 40.957], [61.17, 39.043], [62.523, 37.69], [64.437, 37.69], [65.79, 39.043]];  // bolt window 1, 8 points
void_3 = [[42.31, 64.437], [40.957, 65.79], [39.043, 65.79], [37.69, 64.437], [37.69, 62.523], [39.043, 61.17], [40.957, 61.17], [42.31, 62.523]];  // bolt window 2, 8 points
void_4 = [[18.83, 40.957], [17.477, 42.31], [15.563, 42.31], [14.21, 40.957], [14.21, 39.043], [15.563, 37.69], [17.477, 37.69], [18.83, 39.043]];  // bolt window 3, 8 points
void_5 = [[42.31, 17.477], [40.957, 18.83], [39.043, 18.83], [37.69, 17.477], [37.69, 15.563], [39.043, 14.21], [40.957, 14.21], [42.31, 15.563]];  // bolt window 4, 8 points

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
