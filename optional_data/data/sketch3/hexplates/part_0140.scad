$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 8-gon R35, 4 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 8;                // number of polygon sides
plate_r = 35;             // circumscribed radius of the polygon
bore_r = 10;              // centre bore radius
bolts = 4;                // number of bolt windows
ring_r = 21.17;           // bolt-circle radius
bolt_r = 3;               // bolt window radius
plate_t = 8;              // plate thickness, Z (extrusion height)
fit_tol = 0.05;           // declared fit tolerance (prompt contract)
free_tol = 0.2;           // declared free tolerance (prompt contract)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[70, 35], [59.749, 59.749], [35, 70], [10.251, 59.749], [0, 35], [10.251, 10.251], [35, 0], [59.749, 10.251]];  // primary outline, 8 points, counter clockwise
void_1 = [[44.239, 38.827], [38.827, 44.239], [31.173, 44.239], [25.761, 38.827], [25.761, 31.173], [31.173, 25.761], [38.827, 25.761], [44.239, 31.173]];  // centre bore, 8 points
void_2 = [[58.942, 36.148], [57.318, 37.772], [55.022, 37.772], [53.398, 36.148], [53.398, 33.852], [55.022, 32.228], [57.318, 32.228], [58.942, 33.852]];  // bolt window 1, 8 points
void_3 = [[37.772, 57.318], [36.148, 58.942], [33.852, 58.942], [32.228, 57.318], [32.228, 55.022], [33.852, 53.398], [36.148, 53.398], [37.772, 55.022]];  // bolt window 2, 8 points
void_4 = [[16.602, 36.148], [14.978, 37.772], [12.682, 37.772], [11.058, 36.148], [11.058, 33.852], [12.682, 32.228], [14.978, 32.228], [16.602, 33.852]];  // bolt window 3, 8 points
void_5 = [[37.772, 14.978], [36.148, 16.602], [33.852, 16.602], [32.228, 14.978], [32.228, 12.682], [33.852, 11.058], [36.148, 11.058], [37.772, 12.682]];  // bolt window 4, 8 points

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
