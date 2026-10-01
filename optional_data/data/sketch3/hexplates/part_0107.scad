$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 8-gon R25, 4 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 8;                // number of polygon sides
plate_r = 25;             // circumscribed radius of the polygon
bore_r = 10;              // centre bore radius
bolts = 4;                // number of bolt windows
ring_r = 16.55;           // bolt-circle radius
bolt_r = 4;               // bolt window radius
plate_t = 10;             // plate thickness, Z (extrusion height)
fit_tol = 0.1;            // declared fit tolerance (prompt contract)
free_tol = 0.5;           // declared free tolerance (prompt contract)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[50, 25], [42.678, 42.678], [25, 50], [7.322, 42.678], [0, 25], [7.322, 7.322], [25, 0], [42.678, 7.322]];  // primary outline, 8 points, counter clockwise
void_1 = [[34.239, 28.827], [28.827, 34.239], [21.173, 34.239], [15.761, 28.827], [15.761, 21.173], [21.173, 15.761], [28.827, 15.761], [34.239, 21.173]];  // centre bore, 8 points
void_2 = [[45.246, 26.531], [43.081, 28.696], [40.019, 28.696], [37.854, 26.531], [37.854, 23.469], [40.019, 21.304], [43.081, 21.304], [45.246, 23.469]];  // bolt window 1, 8 points
void_3 = [[28.696, 43.081], [26.531, 45.246], [23.469, 45.246], [21.304, 43.081], [21.304, 40.019], [23.469, 37.854], [26.531, 37.854], [28.696, 40.019]];  // bolt window 2, 8 points
void_4 = [[12.146, 26.531], [9.981, 28.696], [6.919, 28.696], [4.754, 26.531], [4.754, 23.469], [6.919, 21.304], [9.981, 21.304], [12.146, 23.469]];  // bolt window 3, 8 points
void_5 = [[28.696, 9.981], [26.531, 12.146], [23.469, 12.146], [21.304, 9.981], [21.304, 6.919], [23.469, 4.754], [26.531, 4.754], [28.696, 6.919]];  // bolt window 4, 8 points

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
