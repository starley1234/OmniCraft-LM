$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 6-gon R30, 6 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 6;                // number of polygon sides
plate_r = 30;             // circumscribed radius of the polygon
bore_r = 10;              // centre bore radius
bolts = 6;                // number of bolt windows
ring_r = 20.78;           // bolt-circle radius
bolt_r = 4;               // bolt window radius
plate_t = 8;              // plate thickness, Z (extrusion height)
fit_tol = 0.02;           // declared fit tolerance (prompt contract)
free_tol = 0.2;           // declared free tolerance (prompt contract)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[60, 25.981], [45, 51.962], [15, 51.962], [0, 25.981], [15, 0], [45, 0]];  // primary outline, 6 points, counter clockwise
void_1 = [[39.239, 29.808], [33.827, 35.22], [26.173, 35.22], [20.761, 29.808], [20.761, 22.154], [26.173, 16.742], [33.827, 16.742], [39.239, 22.154]];  // centre bore, 8 points
void_2 = [[54.476, 27.512], [52.311, 29.677], [49.249, 29.677], [47.084, 27.512], [47.084, 24.45], [49.249, 22.285], [52.311, 22.285], [54.476, 24.45]];  // bolt window 1, 8 points
void_3 = [[44.086, 45.508], [41.921, 47.673], [38.859, 47.673], [36.694, 45.508], [36.694, 42.446], [38.859, 40.281], [41.921, 40.281], [44.086, 42.446]];  // bolt window 2, 8 points
void_4 = [[23.306, 45.508], [21.141, 47.673], [18.079, 47.673], [15.914, 45.508], [15.914, 42.446], [18.079, 40.281], [21.141, 40.281], [23.306, 42.446]];  // bolt window 3, 8 points
void_5 = [[12.916, 27.512], [10.751, 29.677], [7.689, 29.677], [5.524, 27.512], [5.524, 24.45], [7.689, 22.285], [10.751, 22.285], [12.916, 24.45]];  // bolt window 4, 8 points
void_6 = [[23.306, 9.516], [21.141, 11.681], [18.079, 11.681], [15.914, 9.516], [15.914, 6.454], [18.079, 4.289], [21.141, 4.289], [23.306, 6.454]];  // bolt window 5, 8 points
void_7 = [[44.086, 9.516], [41.921, 11.681], [38.859, 11.681], [36.694, 9.516], [36.694, 6.454], [38.859, 4.289], [41.921, 4.289], [44.086, 6.454]];  // bolt window 6, 8 points

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
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_6);
  translate([0, 0, -1])
    linear_extrude(height = plate_t + 2) polygon(points = void_7);
}
