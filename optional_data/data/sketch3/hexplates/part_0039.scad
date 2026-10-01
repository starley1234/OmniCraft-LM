$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 8-gon R30, 3 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 8;                // number of polygon sides
plate_r = 30;             // circumscribed radius of the polygon
bore_r = 10;              // centre bore radius
bolts = 3;                // number of bolt windows
ring_r = 18.86;           // bolt-circle radius
bolt_r = 3;               // bolt window radius
plate_t = 10;             // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[60, 30], [51.213, 51.213], [30, 60], [8.787, 51.213], [0, 30], [8.787, 8.787], [30, 0], [51.213, 8.787]];  // primary outline, 8 points, counter clockwise
void_1 = [[39.239, 33.827], [33.827, 39.239], [26.173, 39.239], [20.761, 33.827], [20.761, 26.173], [26.173, 20.761], [33.827, 20.761], [39.239, 26.173]];  // centre bore, 8 points
void_2 = [[51.632, 31.148], [50.008, 32.772], [47.712, 32.772], [46.088, 31.148], [46.088, 28.852], [47.712, 27.228], [50.008, 27.228], [51.632, 28.852]];  // bolt window 1, 8 points
void_3 = [[23.342, 47.481], [21.718, 49.105], [19.422, 49.105], [17.798, 47.481], [17.798, 45.185], [19.422, 43.562], [21.718, 43.562], [23.342, 45.185]];  // bolt window 2, 8 points
void_4 = [[23.342, 14.815], [21.718, 16.438], [19.422, 16.438], [17.798, 14.815], [17.798, 12.519], [19.422, 10.895], [21.718, 10.895], [23.342, 12.519]];  // bolt window 3, 8 points

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
