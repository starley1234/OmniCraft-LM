$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 8-gon R30, 4 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 8;                // number of polygon sides
plate_r = 30;             // circumscribed radius of the polygon
bore_r = 10;              // centre bore radius
bolts = 4;                // number of bolt windows
ring_r = 18.86;           // bolt-circle radius
bolt_r = 2.5;             // bolt window radius
plate_t = 10;             // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[60, 30], [51.213, 51.213], [30, 60], [8.787, 51.213], [0, 30], [8.787, 8.787], [30, 0], [51.213, 8.787]];  // primary outline, 8 points, counter clockwise
void_1 = [[39.239, 33.827], [33.827, 39.239], [26.173, 39.239], [20.761, 33.827], [20.761, 26.173], [26.173, 20.761], [33.827, 20.761], [39.239, 26.173]];  // centre bore, 8 points
void_2 = [[51.17, 30.957], [49.817, 32.31], [47.903, 32.31], [46.55, 30.957], [46.55, 29.043], [47.903, 27.69], [49.817, 27.69], [51.17, 29.043]];  // bolt window 1, 8 points
void_3 = [[32.31, 49.817], [30.957, 51.17], [29.043, 51.17], [27.69, 49.817], [27.69, 47.903], [29.043, 46.55], [30.957, 46.55], [32.31, 47.903]];  // bolt window 2, 8 points
void_4 = [[13.45, 30.957], [12.097, 32.31], [10.183, 32.31], [8.83, 30.957], [8.83, 29.043], [10.183, 27.69], [12.097, 27.69], [13.45, 29.043]];  // bolt window 3, 8 points
void_5 = [[32.31, 12.097], [30.957, 13.45], [29.043, 13.45], [27.69, 12.097], [27.69, 10.183], [29.043, 8.83], [30.957, 8.83], [32.31, 10.183]];  // bolt window 4, 8 points

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
