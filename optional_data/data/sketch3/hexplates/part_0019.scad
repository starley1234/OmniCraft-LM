$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 8-gon R30, 6 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 8;                // number of polygon sides
plate_r = 30;             // circumscribed radius of the polygon
bore_r = 6;               // centre bore radius
bolts = 6;                // number of bolt windows
ring_r = 16.86;           // bolt-circle radius
bolt_r = 4;               // bolt window radius
plate_t = 5;              // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[58.847, 35.276], [46.091, 54.368], [23.571, 58.847], [4.479, 46.091], [0, 23.571], [12.756, 4.479], [35.276, 0], [54.368, 12.756]];  // primary outline, 8 points, counter clockwise
void_1 = [[34.967, 31.72], [31.72, 34.967], [27.128, 34.967], [23.881, 31.72], [23.881, 27.128], [27.128, 23.881], [31.72, 23.881], [34.967, 27.128]];  // centre bore, 8 points
void_2 = [[49.656, 34.244], [47.491, 36.409], [44.429, 36.409], [42.265, 34.244], [42.265, 31.182], [44.429, 29.018], [47.491, 29.018], [49.656, 31.182]];  // bolt window 1, 8 points
void_3 = [[38.539, 46.92], [36.374, 49.085], [33.313, 49.085], [31.148, 46.92], [31.148, 43.859], [33.313, 41.694], [36.374, 41.694], [38.539, 43.859]];  // bolt window 2, 8 points
void_4 = [[22.003, 43.631], [19.838, 45.796], [16.777, 45.796], [14.612, 43.631], [14.612, 40.569], [16.777, 38.405], [19.838, 38.405], [22.003, 40.569]];  // bolt window 3, 8 points
void_5 = [[16.583, 27.666], [14.419, 29.83], [11.357, 29.83], [9.192, 27.666], [9.192, 24.604], [11.357, 22.439], [14.419, 22.439], [16.583, 24.604]];  // bolt window 4, 8 points
void_6 = [[27.7, 14.989], [25.535, 17.154], [22.474, 17.154], [20.309, 14.989], [20.309, 11.928], [22.474, 9.763], [25.535, 9.763], [27.7, 11.928]];  // bolt window 5, 8 points
void_7 = [[44.236, 18.279], [42.071, 20.443], [39.01, 20.443], [36.845, 18.279], [36.845, 15.217], [39.01, 13.052], [42.071, 13.052], [44.236, 15.217]];  // bolt window 6, 8 points

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
