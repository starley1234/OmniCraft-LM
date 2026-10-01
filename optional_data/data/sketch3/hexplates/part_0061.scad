$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 8-gon R25, 3 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 8;                // number of polygon sides
plate_r = 25;             // circumscribed radius of the polygon
bore_r = 6;               // centre bore radius
bolts = 3;                // number of bolt windows
ring_r = 14.55;           // bolt-circle radius
bolt_r = 2.5;             // bolt window radius
plate_t = 5;              // plate thickness, Z (extrusion height)
fit_tol = 0.1;            // declared fit tolerance (prompt contract)
free_tol = 0.5;           // declared free tolerance (prompt contract)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[50, 25], [42.678, 42.678], [25, 50], [7.322, 42.678], [0, 25], [7.322, 7.322], [25, 0], [42.678, 7.322]];  // primary outline, 8 points, counter clockwise
void_1 = [[30.543, 27.296], [27.296, 30.543], [22.704, 30.543], [19.457, 27.296], [19.457, 22.704], [22.704, 19.457], [27.296, 19.457], [30.543, 22.704]];  // centre bore, 8 points
void_2 = [[41.86, 25.957], [40.507, 27.31], [38.593, 27.31], [37.24, 25.957], [37.24, 24.043], [38.593, 22.69], [40.507, 22.69], [41.86, 24.043]];  // bolt window 1, 8 points
void_3 = [[20.035, 38.557], [18.682, 39.91], [16.768, 39.91], [15.415, 38.557], [15.415, 36.644], [16.768, 35.291], [18.682, 35.291], [20.035, 36.644]];  // bolt window 2, 8 points
void_4 = [[20.035, 13.356], [18.682, 14.709], [16.768, 14.709], [15.415, 13.356], [15.415, 11.443], [16.768, 10.09], [18.682, 10.09], [20.035, 11.443]];  // bolt window 3, 8 points

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
