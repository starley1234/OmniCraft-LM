$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 8-gon R35, 4 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 8;                // number of polygon sides
plate_r = 35;             // circumscribed radius of the polygon
bore_r = 8;               // centre bore radius
bolts = 4;                // number of bolt windows
ring_r = 20.17;           // bolt-circle radius
bolt_r = 4;               // bolt window radius
plate_t = 6;              // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[70, 35], [59.749, 59.749], [35, 70], [10.251, 59.749], [0, 35], [10.251, 10.251], [35, 0], [59.749, 10.251]];  // primary outline, 8 points, counter clockwise
void_1 = [[42.391, 38.061], [38.061, 42.391], [31.939, 42.391], [27.609, 38.061], [27.609, 31.939], [31.939, 27.609], [38.061, 27.609], [42.391, 31.939]];  // centre bore, 8 points
void_2 = [[58.866, 36.531], [56.701, 38.696], [53.639, 38.696], [51.474, 36.531], [51.474, 33.469], [53.639, 31.304], [56.701, 31.304], [58.866, 33.469]];  // bolt window 1, 8 points
void_3 = [[38.696, 56.701], [36.531, 58.866], [33.469, 58.866], [31.304, 56.701], [31.304, 53.639], [33.469, 51.474], [36.531, 51.474], [38.696, 53.639]];  // bolt window 2, 8 points
void_4 = [[18.526, 36.531], [16.361, 38.696], [13.299, 38.696], [11.134, 36.531], [11.134, 33.469], [13.299, 31.304], [16.361, 31.304], [18.526, 33.469]];  // bolt window 3, 8 points
void_5 = [[38.696, 16.361], [36.531, 18.526], [33.469, 18.526], [31.304, 16.361], [31.304, 13.299], [33.469, 11.134], [36.531, 11.134], [38.696, 13.299]];  // bolt window 4, 8 points

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
