$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 6-gon R30, 4 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 6;                // number of polygon sides
plate_r = 30;             // circumscribed radius of the polygon
bore_r = 10;              // centre bore radius
bolts = 4;                // number of bolt windows
ring_r = 20.78;           // bolt-circle radius
bolt_r = 4;               // bolt window radius
plate_t = 10;             // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[60, 25.981], [45, 51.962], [15, 51.962], [0, 25.981], [15, 0], [45, 0]];  // primary outline, 6 points, counter clockwise
void_1 = [[39.239, 29.808], [33.827, 35.22], [26.173, 35.22], [20.761, 29.808], [20.761, 22.154], [26.173, 16.742], [33.827, 16.742], [39.239, 22.154]];  // centre bore, 8 points
void_2 = [[54.476, 27.512], [52.311, 29.677], [49.249, 29.677], [47.084, 27.512], [47.084, 24.45], [49.249, 22.285], [52.311, 22.285], [54.476, 24.45]];  // bolt window 1, 8 points
void_3 = [[33.696, 48.292], [31.531, 50.457], [28.469, 50.457], [26.304, 48.292], [26.304, 45.23], [28.469, 43.065], [31.531, 43.065], [33.696, 45.23]];  // bolt window 2, 8 points
void_4 = [[12.916, 27.512], [10.751, 29.677], [7.689, 29.677], [5.524, 27.512], [5.524, 24.45], [7.689, 22.285], [10.751, 22.285], [12.916, 24.45]];  // bolt window 3, 8 points
void_5 = [[33.696, 6.732], [31.531, 8.897], [28.469, 8.897], [26.304, 6.732], [26.304, 3.67], [28.469, 1.505], [31.531, 1.505], [33.696, 3.67]];  // bolt window 4, 8 points

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
