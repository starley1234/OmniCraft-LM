$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 8-gon R30, 6 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 8;                // number of polygon sides
plate_r = 30;             // circumscribed radius of the polygon
bore_r = 8;               // centre bore radius
bolts = 6;                // number of bolt windows
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
void_3 = [[42.626, 46.998], [40.461, 49.163], [37.399, 49.163], [35.234, 46.998], [35.234, 43.936], [37.399, 41.772], [40.461, 41.772], [42.626, 43.936]];  // bolt window 2, 8 points
void_4 = [[24.766, 46.998], [22.601, 49.163], [19.539, 49.163], [17.374, 46.998], [17.374, 43.936], [19.539, 41.772], [22.601, 41.772], [24.766, 43.936]];  // bolt window 3, 8 points
void_5 = [[15.836, 31.531], [13.671, 33.696], [10.609, 33.696], [8.444, 31.531], [8.444, 28.469], [10.609, 26.304], [13.671, 26.304], [15.836, 28.469]];  // bolt window 4, 8 points
void_6 = [[24.766, 16.064], [22.601, 18.228], [19.539, 18.228], [17.374, 16.064], [17.374, 13.002], [19.539, 10.837], [22.601, 10.837], [24.766, 13.002]];  // bolt window 5, 8 points
void_7 = [[42.626, 16.064], [40.461, 18.228], [37.399, 18.228], [35.234, 16.064], [35.234, 13.002], [37.399, 10.837], [40.461, 10.837], [42.626, 13.002]];  // bolt window 6, 8 points

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
