$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 8-gon R25, 4 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 8;                // number of polygon sides
plate_r = 25;             // circumscribed radius of the polygon
bore_r = 6;               // centre bore radius
bolts = 4;                // number of bolt windows
ring_r = 14.55;           // bolt-circle radius
bolt_r = 4;               // bolt window radius
plate_t = 5;              // plate thickness, Z (extrusion height)
fit_tol = 0.05;           // declared fit tolerance (prompt contract)
free_tol = 0.2;           // declared free tolerance (prompt contract)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[50, 25], [42.678, 42.678], [25, 50], [7.322, 42.678], [0, 25], [7.322, 7.322], [25, 0], [42.678, 7.322]];  // primary outline, 8 points, counter clockwise
void_1 = [[30.543, 27.296], [27.296, 30.543], [22.704, 30.543], [19.457, 27.296], [19.457, 22.704], [22.704, 19.457], [27.296, 19.457], [30.543, 22.704]];  // centre bore, 8 points
void_2 = [[43.246, 26.531], [41.081, 28.696], [38.019, 28.696], [35.854, 26.531], [35.854, 23.469], [38.019, 21.304], [41.081, 21.304], [43.246, 23.469]];  // bolt window 1, 8 points
void_3 = [[28.696, 41.081], [26.531, 43.246], [23.469, 43.246], [21.304, 41.081], [21.304, 38.019], [23.469, 35.854], [26.531, 35.854], [28.696, 38.019]];  // bolt window 2, 8 points
void_4 = [[14.146, 26.531], [11.981, 28.696], [8.919, 28.696], [6.754, 26.531], [6.754, 23.469], [8.919, 21.304], [11.981, 21.304], [14.146, 23.469]];  // bolt window 3, 8 points
void_5 = [[28.696, 11.981], [26.531, 14.146], [23.469, 14.146], [21.304, 11.981], [21.304, 8.919], [23.469, 6.754], [26.531, 6.754], [28.696, 8.919]];  // bolt window 4, 8 points

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
