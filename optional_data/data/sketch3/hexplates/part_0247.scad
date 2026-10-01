$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 8-gon R25, 6 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 8;                // number of polygon sides
plate_r = 25;             // circumscribed radius of the polygon
bore_r = 6;               // centre bore radius
bolts = 6;                // number of bolt windows
ring_r = 14.55;           // bolt-circle radius
bolt_r = 4;               // bolt window radius
plate_t = 10;             // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[49.039, 29.397], [38.409, 45.306], [19.642, 49.039], [3.733, 38.409], [0, 19.642], [10.63, 3.733], [29.397, 0], [45.306, 10.63]];  // primary outline, 8 points, counter clockwise
void_1 = [[30.063, 26.816], [26.816, 30.063], [22.224, 30.063], [18.977, 26.816], [18.977, 22.224], [22.224, 18.977], [26.816, 18.977], [30.063, 22.224]];  // centre bore, 8 points
void_2 = [[42.486, 28.889], [40.321, 31.054], [37.26, 31.054], [35.095, 28.889], [35.095, 25.828], [37.26, 23.663], [40.321, 23.663], [42.486, 25.828]];  // bolt window 1, 8 points
void_3 = [[32.892, 39.829], [30.728, 41.993], [27.666, 41.993], [25.501, 39.829], [25.501, 36.767], [27.666, 34.602], [30.728, 34.602], [32.892, 36.767]];  // bolt window 2, 8 points
void_4 = [[18.622, 36.99], [16.457, 39.155], [13.396, 39.155], [11.231, 36.99], [11.231, 33.929], [13.396, 31.764], [16.457, 31.764], [18.622, 33.929]];  // bolt window 3, 8 points
void_5 = [[13.945, 23.212], [11.78, 25.377], [8.719, 25.377], [6.554, 23.212], [6.554, 20.151], [8.719, 17.986], [11.78, 17.986], [13.945, 20.151]];  // bolt window 4, 8 points
void_6 = [[23.539, 12.273], [21.374, 14.438], [18.312, 14.438], [16.148, 12.273], [16.148, 9.211], [18.312, 7.047], [21.374, 7.047], [23.539, 9.211]];  // bolt window 5, 8 points
void_7 = [[37.809, 15.111], [35.644, 17.276], [32.583, 17.276], [30.418, 15.111], [30.418, 12.05], [32.583, 9.885], [35.644, 9.885], [37.809, 12.05]];  // bolt window 6, 8 points

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
