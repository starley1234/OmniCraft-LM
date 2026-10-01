$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 8-gon R30, 3 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 8;                // number of polygon sides
plate_r = 30;             // circumscribed radius of the polygon
bore_r = 6;               // centre bore radius
bolts = 3;                // number of bolt windows
ring_r = 16.86;           // bolt-circle radius
bolt_r = 3;               // bolt window radius
plate_t = 10;             // plate thickness, Z (extrusion height)
fit_tol = 0.05;           // declared fit tolerance (prompt contract)
free_tol = 0.2;           // declared free tolerance (prompt contract)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[58.847, 35.276], [46.091, 54.368], [23.571, 58.847], [4.479, 46.091], [0, 23.571], [12.756, 4.479], [35.276, 0], [54.368, 12.756]];  // primary outline, 8 points, counter clockwise
void_1 = [[34.967, 31.72], [31.72, 34.967], [27.128, 34.967], [23.881, 31.72], [23.881, 27.128], [27.128, 23.881], [31.72, 23.881], [34.967, 27.128]];  // centre bore, 8 points
void_2 = [[48.732, 33.861], [47.108, 35.485], [44.812, 35.485], [43.188, 33.861], [43.188, 31.565], [44.812, 29.942], [47.108, 29.942], [48.732, 31.565]];  // bolt window 1, 8 points
void_3 = [[21.079, 43.248], [19.455, 44.872], [17.159, 44.872], [15.536, 43.248], [15.536, 40.952], [17.159, 39.328], [19.455, 39.328], [21.079, 40.952]];  // bolt window 2, 8 points
void_4 = [[26.776, 14.607], [25.153, 16.23], [22.856, 16.23], [21.233, 14.607], [21.233, 12.311], [22.856, 10.687], [25.153, 10.687], [26.776, 12.311]];  // bolt window 3, 8 points

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
