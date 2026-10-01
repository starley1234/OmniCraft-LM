$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 6-gon R30, 3 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 6;                // number of polygon sides
plate_r = 30;             // circumscribed radius of the polygon
bore_r = 10;              // centre bore radius
bolts = 3;                // number of bolt windows
ring_r = 22.28;           // bolt-circle radius
bolt_r = 2.5;             // bolt window radius
plate_t = 8;              // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[60, 25.981], [45, 51.962], [15, 51.962], [0, 25.981], [15, 0], [45, 0]];  // primary outline, 6 points, counter clockwise
void_1 = [[39.239, 29.808], [33.827, 35.22], [26.173, 35.22], [20.761, 29.808], [20.761, 22.154], [26.173, 16.742], [33.827, 16.742], [39.239, 22.154]];  // centre bore, 8 points
void_2 = [[54.59, 26.938], [53.237, 28.291], [51.323, 28.291], [49.97, 26.938], [49.97, 25.024], [51.323, 23.671], [53.237, 23.671], [54.59, 25.024]];  // bolt window 1, 8 points
void_3 = [[21.17, 46.233], [19.817, 47.586], [17.903, 47.586], [16.55, 46.233], [16.55, 44.319], [17.903, 42.966], [19.817, 42.966], [21.17, 44.319]];  // bolt window 2, 8 points
void_4 = [[21.17, 7.643], [19.817, 8.996], [17.903, 8.996], [16.55, 7.643], [16.55, 5.729], [17.903, 4.376], [19.817, 4.376], [21.17, 5.729]];  // bolt window 3, 8 points

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
