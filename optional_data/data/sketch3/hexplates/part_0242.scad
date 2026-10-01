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
bolt_r = 3;               // bolt window radius
plate_t = 10;             // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[80, 40], [68.284, 68.284], [40, 80], [11.716, 68.284], [0, 40], [11.716, 11.716], [40, 0], [68.284, 11.716]];  // primary outline, 8 points, counter clockwise
void_1 = [[49.239, 43.827], [43.827, 49.239], [36.173, 49.239], [30.761, 43.827], [30.761, 36.173], [36.173, 30.761], [43.827, 30.761], [49.239, 36.173]];  // centre bore, 8 points
void_2 = [[66.252, 41.148], [64.628, 42.772], [62.332, 42.772], [60.708, 41.148], [60.708, 38.852], [62.332, 37.228], [64.628, 37.228], [66.252, 38.852]];  // bolt window 1, 8 points
void_3 = [[31.032, 61.482], [29.408, 63.106], [27.112, 63.106], [25.488, 61.482], [25.488, 59.186], [27.112, 57.563], [29.408, 57.563], [31.032, 59.186]];  // bolt window 2, 8 points
void_4 = [[31.032, 20.814], [29.408, 22.437], [27.112, 22.437], [25.488, 20.814], [25.488, 18.518], [27.112, 16.894], [29.408, 16.894], [31.032, 18.518]];  // bolt window 3, 8 points

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
