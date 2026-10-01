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
bolt_r = 2.5;             // bolt window radius
plate_t = 8;              // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[60, 30], [51.213, 51.213], [30, 60], [8.787, 51.213], [0, 30], [8.787, 8.787], [30, 0], [51.213, 8.787]];  // primary outline, 8 points, counter clockwise
void_1 = [[39.239, 33.827], [33.827, 39.239], [26.173, 39.239], [20.761, 33.827], [20.761, 26.173], [26.173, 20.761], [33.827, 20.761], [39.239, 26.173]];  // centre bore, 8 points
void_2 = [[51.17, 30.957], [49.817, 32.31], [47.903, 32.31], [46.55, 30.957], [46.55, 29.043], [47.903, 27.69], [49.817, 27.69], [51.17, 29.043]];  // bolt window 1, 8 points
void_3 = [[22.88, 47.29], [21.527, 48.643], [19.613, 48.643], [18.26, 47.29], [18.26, 45.377], [19.613, 44.024], [21.527, 44.024], [22.88, 45.377]];  // bolt window 2, 8 points
void_4 = [[22.88, 14.623], [21.527, 15.976], [19.613, 15.976], [18.26, 14.623], [18.26, 12.71], [19.613, 11.357], [21.527, 11.357], [22.88, 12.71]];  // bolt window 3, 8 points

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
