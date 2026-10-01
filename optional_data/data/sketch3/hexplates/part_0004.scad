$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 6-gon R40, 3 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 6;                // number of polygon sides
plate_r = 40;             // circumscribed radius of the polygon
bore_r = 8;               // centre bore radius
bolts = 3;                // number of bolt windows
ring_r = 30.94;           // bolt-circle radius
bolt_r = 2.5;             // bolt window radius
plate_t = 6;              // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[77.274, 48.99], [48.99, 77.274], [10.353, 66.921], [0, 28.284], [28.284, 0], [66.921, 10.353]];  // primary outline, 6 points, counter clockwise
void_1 = [[46.028, 41.698], [41.698, 46.028], [35.576, 46.028], [31.246, 41.698], [31.246, 35.576], [35.576, 31.246], [41.698, 31.246], [46.028, 35.576]];  // centre bore, 8 points
void_2 = [[70.832, 47.602], [69.479, 48.955], [67.566, 48.955], [66.213, 47.602], [66.213, 45.688], [67.566, 44.335], [69.479, 44.335], [70.832, 45.688]];  // bolt window 1, 8 points
void_3 = [[19.069, 61.472], [17.716, 62.825], [15.802, 62.825], [14.449, 61.472], [14.449, 59.558], [15.802, 58.205], [17.716, 58.205], [19.069, 59.558]];  // bolt window 2, 8 points
void_4 = [[32.939, 9.708], [31.586, 11.061], [29.672, 11.061], [28.319, 9.708], [28.319, 7.795], [29.672, 6.442], [31.586, 6.442], [32.939, 7.795]];  // bolt window 3, 8 points

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
