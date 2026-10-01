$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 8-gon R35, 6 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 8;                // number of polygon sides
plate_r = 35;             // circumscribed radius of the polygon
bore_r = 8;               // centre bore radius
bolts = 6;                // number of bolt windows
ring_r = 20.17;           // bolt-circle radius
bolt_r = 3;               // bolt window radius
plate_t = 8;              // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[68.655, 41.156], [53.772, 63.429], [27.499, 68.655], [5.226, 53.772], [0, 27.499], [14.883, 5.226], [41.156, 0], [63.429, 14.883]];  // primary outline, 8 points, counter clockwise
void_1 = [[41.718, 37.388], [37.388, 41.718], [31.266, 41.718], [26.936, 37.388], [26.936, 31.266], [31.266, 26.936], [37.388, 26.936], [41.718, 31.266]];  // centre bore, 8 points
void_2 = [[56.881, 39.41], [55.257, 41.034], [52.961, 41.034], [51.338, 39.41], [51.338, 37.114], [52.961, 35.49], [55.257, 35.49], [56.881, 37.114]];  // bolt window 1, 8 points
void_3 = [[43.582, 54.575], [41.958, 56.198], [39.662, 56.198], [38.039, 54.575], [38.039, 52.279], [39.662, 50.655], [41.958, 50.655], [43.582, 52.279]];  // bolt window 2, 8 points
void_4 = [[23.8, 50.64], [22.176, 52.263], [19.88, 52.263], [18.256, 50.64], [18.256, 48.344], [19.88, 46.72], [22.176, 46.72], [23.8, 48.344]];  // bolt window 3, 8 points
void_5 = [[17.316, 31.54], [15.693, 33.164], [13.397, 33.164], [11.773, 31.54], [11.773, 29.244], [13.397, 27.62], [15.693, 27.62], [17.316, 29.244]];  // bolt window 4, 8 points
void_6 = [[30.615, 16.375], [28.992, 17.999], [26.696, 17.999], [25.072, 16.375], [25.072, 14.079], [26.696, 12.456], [28.992, 12.456], [30.615, 14.079]];  // bolt window 5, 8 points
void_7 = [[50.398, 20.31], [48.774, 21.934], [46.478, 21.934], [44.854, 20.31], [44.854, 18.014], [46.478, 16.391], [48.774, 16.391], [50.398, 18.014]];  // bolt window 6, 8 points

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
