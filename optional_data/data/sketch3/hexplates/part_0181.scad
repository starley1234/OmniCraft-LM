$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 6-gon R35, 4 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 6;                // number of polygon sides
plate_r = 35;             // circumscribed radius of the polygon
bore_r = 10;              // centre bore radius
bolts = 4;                // number of bolt windows
ring_r = 26.61;           // bolt-circle radius
bolt_r = 2.5;             // bolt window radius
plate_t = 8;              // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[70, 30.311], [52.5, 60.622], [17.5, 60.622], [0, 30.311], [17.5, 0], [52.5, 0]];  // primary outline, 6 points, counter clockwise
void_1 = [[44.239, 34.138], [38.827, 39.55], [31.173, 39.55], [25.761, 34.138], [25.761, 26.484], [31.173, 21.072], [38.827, 21.072], [44.239, 26.484]];  // centre bore, 8 points
void_2 = [[63.92, 31.268], [62.567, 32.621], [60.653, 32.621], [59.3, 31.268], [59.3, 29.354], [60.653, 28.001], [62.567, 28.001], [63.92, 29.354]];  // bolt window 1, 8 points
void_3 = [[37.31, 57.878], [35.957, 59.231], [34.043, 59.231], [32.69, 57.878], [32.69, 55.964], [34.043, 54.611], [35.957, 54.611], [37.31, 55.964]];  // bolt window 2, 8 points
void_4 = [[10.7, 31.268], [9.347, 32.621], [7.433, 32.621], [6.08, 31.268], [6.08, 29.354], [7.433, 28.001], [9.347, 28.001], [10.7, 29.354]];  // bolt window 3, 8 points
void_5 = [[37.31, 4.658], [35.957, 6.011], [34.043, 6.011], [32.69, 4.658], [32.69, 2.744], [34.043, 1.391], [35.957, 1.391], [37.31, 2.744]];  // bolt window 4, 8 points

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
