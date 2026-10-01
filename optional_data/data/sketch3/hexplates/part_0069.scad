$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 8-gon R30, 3 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 8;                // number of polygon sides
plate_r = 30;             // circumscribed radius of the polygon
bore_r = 8;               // centre bore radius
bolts = 3;                // number of bolt windows
ring_r = 17.86;           // bolt-circle radius
bolt_r = 3;               // bolt window radius
plate_t = 8;              // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[60, 30], [51.213, 51.213], [30, 60], [8.787, 51.213], [0, 30], [8.787, 8.787], [30, 0], [51.213, 8.787]];  // primary outline, 8 points, counter clockwise
void_1 = [[37.391, 33.061], [33.061, 37.391], [26.939, 37.391], [22.609, 33.061], [22.609, 26.939], [26.939, 22.609], [33.061, 22.609], [37.391, 26.939]];  // centre bore, 8 points
void_2 = [[50.632, 31.148], [49.008, 32.772], [46.712, 32.772], [45.088, 31.148], [45.088, 28.852], [46.712, 27.228], [49.008, 27.228], [50.632, 28.852]];  // bolt window 1, 8 points
void_3 = [[23.842, 46.615], [22.218, 48.239], [19.922, 48.239], [18.298, 46.615], [18.298, 44.319], [19.922, 42.696], [22.218, 42.696], [23.842, 44.319]];  // bolt window 2, 8 points
void_4 = [[23.842, 15.681], [22.218, 17.304], [19.922, 17.304], [18.298, 15.681], [18.298, 13.385], [19.922, 11.761], [22.218, 11.761], [23.842, 13.385]];  // bolt window 3, 8 points

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
