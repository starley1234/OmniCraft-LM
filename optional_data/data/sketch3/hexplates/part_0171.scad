$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 8-gon R35, 3 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 8;                // number of polygon sides
plate_r = 35;             // circumscribed radius of the polygon
bore_r = 10;              // centre bore radius
bolts = 3;                // number of bolt windows
ring_r = 21.17;           // bolt-circle radius
bolt_r = 2.5;             // bolt window radius
plate_t = 10;             // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[70, 35], [59.749, 59.749], [35, 70], [10.251, 59.749], [0, 35], [10.251, 10.251], [35, 0], [59.749, 10.251]];  // primary outline, 8 points, counter clockwise
void_1 = [[44.239, 38.827], [38.827, 44.239], [31.173, 44.239], [25.761, 38.827], [25.761, 31.173], [31.173, 25.761], [38.827, 25.761], [44.239, 31.173]];  // centre bore, 8 points
void_2 = [[58.48, 35.957], [57.127, 37.31], [55.213, 37.31], [53.86, 35.957], [53.86, 34.043], [55.213, 32.69], [57.127, 32.69], [58.48, 34.043]];  // bolt window 1, 8 points
void_3 = [[26.725, 54.29], [25.372, 55.643], [23.458, 55.643], [22.105, 54.29], [22.105, 52.377], [23.458, 51.024], [25.372, 51.024], [26.725, 52.377]];  // bolt window 2, 8 points
void_4 = [[26.725, 17.623], [25.372, 18.976], [23.458, 18.976], [22.105, 17.623], [22.105, 15.71], [23.458, 14.357], [25.372, 14.357], [26.725, 15.71]];  // bolt window 3, 8 points

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
