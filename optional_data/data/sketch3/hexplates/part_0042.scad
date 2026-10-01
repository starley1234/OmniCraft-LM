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
bolt_r = 4;               // bolt window radius
plate_t = 6;              // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[60, 30], [51.213, 51.213], [30, 60], [8.787, 51.213], [0, 30], [8.787, 8.787], [30, 0], [51.213, 8.787]];  // primary outline, 8 points, counter clockwise
void_1 = [[37.391, 33.061], [33.061, 37.391], [26.939, 37.391], [22.609, 33.061], [22.609, 26.939], [26.939, 22.609], [33.061, 22.609], [37.391, 26.939]];  // centre bore, 8 points
void_2 = [[51.556, 31.531], [49.391, 33.696], [46.329, 33.696], [44.164, 31.531], [44.164, 28.469], [46.329, 26.304], [49.391, 26.304], [51.556, 28.469]];  // bolt window 1, 8 points
void_3 = [[24.766, 46.998], [22.601, 49.163], [19.539, 49.163], [17.374, 46.998], [17.374, 43.936], [19.539, 41.772], [22.601, 41.772], [24.766, 43.936]];  // bolt window 2, 8 points
void_4 = [[24.766, 16.064], [22.601, 18.228], [19.539, 18.228], [17.374, 16.064], [17.374, 13.002], [19.539, 10.837], [22.601, 10.837], [24.766, 13.002]];  // bolt window 3, 8 points

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
