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

profile = [[68.655, 41.156], [53.772, 63.429], [27.499, 68.655], [5.226, 53.772], [0, 27.499], [14.883, 5.226], [41.156, 0], [63.429, 14.883]];  // primary outline, 8 points, counter clockwise
void_1 = [[41.718, 37.388], [37.388, 41.718], [31.266, 41.718], [26.936, 37.388], [26.936, 31.266], [31.266, 26.936], [37.388, 26.936], [41.718, 31.266]];  // centre bore, 8 points
void_2 = [[57.805, 39.793], [55.64, 41.957], [52.579, 41.957], [50.414, 39.793], [50.414, 36.731], [52.579, 34.566], [55.64, 34.566], [57.805, 36.731]];  // bolt window 1, 8 points
void_3 = [[34.088, 55.64], [31.923, 57.805], [28.861, 57.805], [26.697, 55.64], [26.697, 52.579], [28.861, 50.414], [31.923, 50.414], [34.088, 52.579]];  // bolt window 2, 8 points
void_4 = [[18.24, 31.923], [16.075, 34.088], [13.014, 34.088], [10.849, 31.923], [10.849, 28.861], [13.014, 26.697], [16.075, 26.697], [18.24, 28.861]];  // bolt window 3, 8 points
void_5 = [[41.957, 16.075], [39.793, 18.24], [36.731, 18.24], [34.566, 16.075], [34.566, 13.014], [36.731, 10.849], [39.793, 10.849], [41.957, 13.014]];  // bolt window 4, 8 points

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
