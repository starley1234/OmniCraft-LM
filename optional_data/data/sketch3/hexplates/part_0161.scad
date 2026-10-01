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
plate_t = 10;             // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[58.847, 35.276], [46.091, 54.368], [23.571, 58.847], [4.479, 46.091], [0, 23.571], [12.756, 4.479], [35.276, 0], [54.368, 12.756]];  // primary outline, 8 points, counter clockwise
void_1 = [[36.815, 32.485], [32.485, 36.815], [26.363, 36.815], [22.033, 32.485], [22.033, 26.363], [26.363, 22.033], [32.485, 22.033], [36.815, 26.363]];  // centre bore, 8 points
void_2 = [[50.636, 34.439], [48.472, 36.604], [45.41, 36.604], [43.245, 34.439], [43.245, 31.378], [45.41, 29.213], [48.472, 29.213], [50.636, 31.378]];  // bolt window 1, 8 points
void_3 = [[21.344, 44.383], [19.179, 46.547], [16.117, 46.547], [13.953, 44.383], [13.953, 41.321], [16.117, 39.156], [19.179, 39.156], [21.344, 41.321]];  // bolt window 2, 8 points
void_4 = [[27.379, 14.043], [25.214, 16.207], [22.152, 16.207], [19.988, 14.043], [19.988, 10.981], [22.152, 8.816], [25.214, 8.816], [27.379, 10.981]];  // bolt window 3, 8 points

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
