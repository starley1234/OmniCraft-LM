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
bolt_r = 3;               // bolt window radius
plate_t = 5;              // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[68.655, 41.156], [53.772, 63.429], [27.499, 68.655], [5.226, 53.772], [0, 27.499], [14.883, 5.226], [41.156, 0], [63.429, 14.883]];  // primary outline, 8 points, counter clockwise
void_1 = [[41.718, 37.388], [37.388, 41.718], [31.266, 41.718], [26.936, 37.388], [26.936, 31.266], [31.266, 26.936], [37.388, 26.936], [41.718, 31.266]];  // centre bore, 8 points
void_2 = [[56.881, 39.41], [55.257, 41.034], [52.961, 41.034], [51.338, 39.41], [51.338, 37.114], [52.961, 35.49], [55.257, 35.49], [56.881, 37.114]];  // bolt window 1, 8 points
void_3 = [[33.164, 55.257], [31.54, 56.881], [29.244, 56.881], [27.62, 55.257], [27.62, 52.961], [29.244, 51.338], [31.54, 51.338], [33.164, 52.961]];  // bolt window 2, 8 points
void_4 = [[17.316, 31.54], [15.693, 33.164], [13.397, 33.164], [11.773, 31.54], [11.773, 29.244], [13.397, 27.62], [15.693, 27.62], [17.316, 29.244]];  // bolt window 3, 8 points
void_5 = [[41.034, 15.693], [39.41, 17.316], [37.114, 17.316], [35.49, 15.693], [35.49, 13.397], [37.114, 11.773], [39.41, 11.773], [41.034, 13.397]];  // bolt window 4, 8 points

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
