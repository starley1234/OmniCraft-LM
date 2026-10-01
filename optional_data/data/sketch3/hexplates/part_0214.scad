$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 8-gon R30, 4 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 8;                // number of polygon sides
plate_r = 30;             // circumscribed radius of the polygon
bore_r = 8;               // centre bore radius
bolts = 4;                // number of bolt windows
ring_r = 17.86;           // bolt-circle radius
bolt_r = 4;               // bolt window radius
plate_t = 6;              // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[58.847, 35.276], [46.091, 54.368], [23.571, 58.847], [4.479, 46.091], [0, 23.571], [12.756, 4.479], [35.276, 0], [54.368, 12.756]];  // primary outline, 8 points, counter clockwise
void_1 = [[36.815, 32.485], [32.485, 36.815], [26.363, 36.815], [22.033, 32.485], [22.033, 26.363], [26.363, 22.033], [32.485, 22.033], [36.815, 26.363]];  // centre bore, 8 points
void_2 = [[50.636, 34.439], [48.472, 36.604], [45.41, 36.604], [43.245, 34.439], [43.245, 31.378], [45.41, 29.213], [48.472, 29.213], [50.636, 31.378]];  // bolt window 1, 8 points
void_3 = [[29.635, 48.472], [27.47, 50.636], [24.409, 50.636], [22.244, 48.472], [22.244, 45.41], [24.409, 43.245], [27.47, 43.245], [29.635, 45.41]];  // bolt window 2, 8 points
void_4 = [[15.603, 27.47], [13.438, 29.635], [10.376, 29.635], [8.212, 27.47], [8.212, 24.409], [10.376, 22.244], [13.438, 22.244], [15.603, 24.409]];  // bolt window 3, 8 points
void_5 = [[36.604, 13.438], [34.439, 15.603], [31.378, 15.603], [29.213, 13.438], [29.213, 10.376], [31.378, 8.212], [34.439, 8.212], [36.604, 10.376]];  // bolt window 4, 8 points

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
