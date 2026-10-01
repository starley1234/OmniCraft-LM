$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 8-gon R35, 3 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 8;                // number of polygon sides
plate_r = 35;             // circumscribed radius of the polygon
bore_r = 8;               // centre bore radius
bolts = 3;                // number of bolt windows
ring_r = 20.17;           // bolt-circle radius
bolt_r = 3;               // bolt window radius
plate_t = 8;              // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[70, 35], [59.749, 59.749], [35, 70], [10.251, 59.749], [0, 35], [10.251, 10.251], [35, 0], [59.749, 10.251]];  // primary outline, 8 points, counter clockwise
void_1 = [[42.391, 38.061], [38.061, 42.391], [31.939, 42.391], [27.609, 38.061], [27.609, 31.939], [31.939, 27.609], [38.061, 27.609], [42.391, 31.939]];  // centre bore, 8 points
void_2 = [[57.942, 36.148], [56.318, 37.772], [54.022, 37.772], [52.398, 36.148], [52.398, 33.852], [54.022, 32.228], [56.318, 32.228], [57.942, 33.852]];  // bolt window 1, 8 points
void_3 = [[27.687, 53.616], [26.063, 55.239], [23.767, 55.239], [22.143, 53.616], [22.143, 51.32], [23.767, 49.696], [26.063, 49.696], [27.687, 51.32]];  // bolt window 2, 8 points
void_4 = [[27.687, 18.68], [26.063, 20.304], [23.767, 20.304], [22.143, 18.68], [22.143, 16.384], [23.767, 14.761], [26.063, 14.761], [27.687, 16.384]];  // bolt window 3, 8 points

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
