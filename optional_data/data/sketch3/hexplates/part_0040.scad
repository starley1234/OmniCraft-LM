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
bolt_r = 2.5;             // bolt window radius
plate_t = 5;              // plate thickness, Z (extrusion height)
fit_tol = 0.05;           // declared fit tolerance (prompt contract)
free_tol = 0.3;           // declared free tolerance (prompt contract)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[58.847, 35.276], [46.091, 54.368], [23.571, 58.847], [4.479, 46.091], [0, 23.571], [12.756, 4.479], [35.276, 0], [54.368, 12.756]];  // primary outline, 8 points, counter clockwise
void_1 = [[34.967, 31.72], [31.72, 34.967], [27.128, 34.967], [23.881, 31.72], [23.881, 27.128], [27.128, 23.881], [31.72, 23.881], [34.967, 27.128]];  // centre bore, 8 points
void_2 = [[48.27, 33.67], [46.917, 35.023], [45.003, 35.023], [43.65, 33.67], [43.65, 31.757], [45.003, 30.404], [46.917, 30.404], [48.27, 31.757]];  // bolt window 1, 8 points
void_3 = [[20.617, 43.057], [19.264, 44.41], [17.351, 44.41], [15.998, 43.057], [15.998, 41.143], [17.351, 39.79], [19.264, 39.79], [20.617, 41.143]];  // bolt window 2, 8 points
void_4 = [[26.314, 14.415], [24.961, 15.768], [23.048, 15.768], [21.695, 14.415], [21.695, 12.502], [23.048, 11.149], [24.961, 11.149], [26.314, 12.502]];  // bolt window 3, 8 points

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
