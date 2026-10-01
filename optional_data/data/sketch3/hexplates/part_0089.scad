$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 8-gon R35, 6 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 8;                // number of polygon sides
plate_r = 35;             // circumscribed radius of the polygon
bore_r = 10;              // centre bore radius
bolts = 6;                // number of bolt windows
ring_r = 21.17;           // bolt-circle radius
bolt_r = 3;               // bolt window radius
plate_t = 8;              // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[70, 35], [59.749, 59.749], [35, 70], [10.251, 59.749], [0, 35], [10.251, 10.251], [35, 0], [59.749, 10.251]];  // primary outline, 8 points, counter clockwise
void_1 = [[44.239, 38.827], [38.827, 44.239], [31.173, 44.239], [25.761, 38.827], [25.761, 31.173], [31.173, 25.761], [38.827, 25.761], [44.239, 31.173]];  // centre bore, 8 points
void_2 = [[58.942, 36.148], [57.318, 37.772], [55.022, 37.772], [53.398, 36.148], [53.398, 33.852], [55.022, 32.228], [57.318, 32.228], [58.942, 33.852]];  // bolt window 1, 8 points
void_3 = [[48.357, 54.482], [46.733, 56.105], [44.437, 56.105], [42.813, 54.482], [42.813, 52.186], [44.437, 50.562], [46.733, 50.562], [48.357, 52.186]];  // bolt window 2, 8 points
void_4 = [[27.187, 54.482], [25.563, 56.105], [23.267, 56.105], [21.643, 54.482], [21.643, 52.186], [23.267, 50.562], [25.563, 50.562], [27.187, 52.186]];  // bolt window 3, 8 points
void_5 = [[16.602, 36.148], [14.978, 37.772], [12.682, 37.772], [11.058, 36.148], [11.058, 33.852], [12.682, 32.228], [14.978, 32.228], [16.602, 33.852]];  // bolt window 4, 8 points
void_6 = [[27.187, 17.814], [25.563, 19.438], [23.267, 19.438], [21.643, 17.814], [21.643, 15.518], [23.267, 13.895], [25.563, 13.895], [27.187, 15.518]];  // bolt window 5, 8 points
void_7 = [[48.357, 17.814], [46.733, 19.438], [44.437, 19.438], [42.813, 17.814], [42.813, 15.518], [44.437, 13.895], [46.733, 13.895], [48.357, 15.518]];  // bolt window 6, 8 points

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
