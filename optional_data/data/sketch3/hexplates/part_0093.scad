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
plate_t = 10;             // plate thickness, Z (extrusion height)
fit_tol = 0.02;           // declared fit tolerance (prompt contract)
free_tol = 0.2;           // declared free tolerance (prompt contract)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[60, 30], [51.213, 51.213], [30, 60], [8.787, 51.213], [0, 30], [8.787, 8.787], [30, 0], [51.213, 8.787]];  // primary outline, 8 points, counter clockwise
void_1 = [[35.543, 32.296], [32.296, 35.543], [27.704, 35.543], [24.457, 32.296], [24.457, 27.704], [27.704, 24.457], [32.296, 24.457], [35.543, 27.704]];  // centre bore, 8 points
void_2 = [[49.17, 30.957], [47.817, 32.31], [45.903, 32.31], [44.55, 30.957], [44.55, 29.043], [45.903, 27.69], [47.817, 27.69], [49.17, 29.043]];  // bolt window 1, 8 points
void_3 = [[23.88, 45.558], [22.527, 46.911], [20.613, 46.911], [19.26, 45.558], [19.26, 43.644], [20.613, 42.291], [22.527, 42.291], [23.88, 43.644]];  // bolt window 2, 8 points
void_4 = [[23.88, 16.356], [22.527, 17.709], [20.613, 17.709], [19.26, 16.356], [19.26, 14.442], [20.613, 13.089], [22.527, 13.089], [23.88, 14.442]];  // bolt window 3, 8 points

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
