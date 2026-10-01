$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 6-gon R35, 3 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 6;                // number of polygon sides
plate_r = 35;             // circumscribed radius of the polygon
bore_r = 6;               // centre bore radius
bolts = 3;                // number of bolt windows
ring_r = 26.61;           // bolt-circle radius
bolt_r = 2.5;             // bolt window radius
plate_t = 8;              // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[70, 30.311], [52.5, 60.622], [17.5, 60.622], [0, 30.311], [17.5, 0], [52.5, 0]];  // primary outline, 6 points, counter clockwise
void_1 = [[40.543, 32.607], [37.296, 35.854], [32.704, 35.854], [29.457, 32.607], [29.457, 28.015], [32.704, 24.768], [37.296, 24.768], [40.543, 28.015]];  // centre bore, 8 points
void_2 = [[63.92, 31.268], [62.567, 32.621], [60.653, 32.621], [59.3, 31.268], [59.3, 29.354], [60.653, 28.001], [62.567, 28.001], [63.92, 29.354]];  // bolt window 1, 8 points
void_3 = [[24.005, 54.313], [22.652, 55.666], [20.738, 55.666], [19.385, 54.313], [19.385, 52.399], [20.738, 51.046], [22.652, 51.046], [24.005, 52.399]];  // bolt window 2, 8 points
void_4 = [[24.005, 8.223], [22.652, 9.576], [20.738, 9.576], [19.385, 8.223], [19.385, 6.309], [20.738, 4.956], [22.652, 4.956], [24.005, 6.309]];  // bolt window 3, 8 points

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
