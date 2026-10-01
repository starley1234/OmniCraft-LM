$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 6-gon R30, 4 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 6;                // number of polygon sides
plate_r = 30;             // circumscribed radius of the polygon
bore_r = 10;              // centre bore radius
bolts = 4;                // number of bolt windows
ring_r = 22.28;           // bolt-circle radius
bolt_r = 2.5;             // bolt window radius
plate_t = 6;              // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[60, 25.981], [45, 51.962], [15, 51.962], [0, 25.981], [15, 0], [45, 0]];  // primary outline, 6 points, counter clockwise
void_1 = [[39.239, 29.808], [33.827, 35.22], [26.173, 35.22], [20.761, 29.808], [20.761, 22.154], [26.173, 16.742], [33.827, 16.742], [39.239, 22.154]];  // centre bore, 8 points
void_2 = [[54.59, 26.938], [53.237, 28.291], [51.323, 28.291], [49.97, 26.938], [49.97, 25.024], [51.323, 23.671], [53.237, 23.671], [54.59, 25.024]];  // bolt window 1, 8 points
void_3 = [[32.31, 49.218], [30.957, 50.571], [29.043, 50.571], [27.69, 49.218], [27.69, 47.304], [29.043, 45.951], [30.957, 45.951], [32.31, 47.304]];  // bolt window 2, 8 points
void_4 = [[10.03, 26.938], [8.677, 28.291], [6.763, 28.291], [5.41, 26.938], [5.41, 25.024], [6.763, 23.671], [8.677, 23.671], [10.03, 25.024]];  // bolt window 3, 8 points
void_5 = [[32.31, 4.658], [30.957, 6.011], [29.043, 6.011], [27.69, 4.658], [27.69, 2.744], [29.043, 1.391], [30.957, 1.391], [32.31, 2.744]];  // bolt window 4, 8 points

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
