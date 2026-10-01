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

profile = [[58.847, 35.276], [46.091, 54.368], [23.571, 58.847], [4.479, 46.091], [0, 23.571], [12.756, 4.479], [35.276, 0], [54.368, 12.756]];  // primary outline, 8 points, counter clockwise
void_1 = [[38.663, 33.251], [33.251, 38.663], [25.597, 38.663], [20.185, 33.251], [20.185, 25.597], [25.597, 20.185], [33.251, 20.185], [38.663, 25.597]];  // centre bore, 8 points
void_2 = [[50.231, 34.06], [48.878, 35.413], [46.965, 35.413], [45.612, 34.06], [45.612, 32.147], [46.965, 30.794], [48.878, 30.794], [50.231, 32.147]];  // bolt window 1, 8 points
void_3 = [[28.054, 48.878], [26.701, 50.231], [24.788, 50.231], [23.435, 48.878], [23.435, 46.965], [24.788, 45.612], [26.701, 45.612], [28.054, 46.965]];  // bolt window 2, 8 points
void_4 = [[13.236, 26.701], [11.883, 28.054], [9.97, 28.054], [8.617, 26.701], [8.617, 24.788], [9.97, 23.435], [11.883, 23.435], [13.236, 24.788]];  // bolt window 3, 8 points
void_5 = [[35.413, 11.883], [34.06, 13.236], [32.147, 13.236], [30.794, 11.883], [30.794, 9.97], [32.147, 8.617], [34.06, 8.617], [35.413, 9.97]];  // bolt window 4, 8 points

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
