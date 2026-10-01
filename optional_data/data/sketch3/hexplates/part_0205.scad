$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 8-gon R30, 3 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 8;                // number of polygon sides
plate_r = 30;             // circumscribed radius of the polygon
bore_r = 10;              // centre bore radius
bolts = 3;                // number of bolt windows
ring_r = 18.86;           // bolt-circle radius
bolt_r = 4;               // bolt window radius
plate_t = 10;             // plate thickness, Z (extrusion height)
fit_tol = 0.1;            // declared fit tolerance (prompt contract)
free_tol = 0.3;           // declared free tolerance (prompt contract)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[60, 30], [51.213, 51.213], [30, 60], [8.787, 51.213], [0, 30], [8.787, 8.787], [30, 0], [51.213, 8.787]];  // primary outline, 8 points, counter clockwise
void_1 = [[39.239, 33.827], [33.827, 39.239], [26.173, 39.239], [20.761, 33.827], [20.761, 26.173], [26.173, 20.761], [33.827, 20.761], [39.239, 26.173]];  // centre bore, 8 points
void_2 = [[52.556, 31.531], [50.391, 33.696], [47.329, 33.696], [45.164, 31.531], [45.164, 28.469], [47.329, 26.304], [50.391, 26.304], [52.556, 28.469]];  // bolt window 1, 8 points
void_3 = [[24.266, 47.864], [22.101, 50.029], [19.039, 50.029], [16.874, 47.864], [16.874, 44.803], [19.039, 42.638], [22.101, 42.638], [24.266, 44.803]];  // bolt window 2, 8 points
void_4 = [[24.266, 15.197], [22.101, 17.362], [19.039, 17.362], [16.874, 15.197], [16.874, 12.136], [19.039, 9.971], [22.101, 9.971], [24.266, 12.136]];  // bolt window 3, 8 points

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
