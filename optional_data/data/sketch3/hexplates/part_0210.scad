$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 8-gon R40, 4 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 8;                // number of polygon sides
plate_r = 40;             // circumscribed radius of the polygon
bore_r = 10;              // centre bore radius
bolts = 4;                // number of bolt windows
ring_r = 23.48;           // bolt-circle radius
bolt_r = 4;               // bolt window radius
plate_t = 8;              // plate thickness, Z (extrusion height)
fit_tol = 0.05;           // declared fit tolerance (prompt contract)
free_tol = 0.3;           // declared free tolerance (prompt contract)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[78.463, 47.035], [61.454, 72.49], [31.428, 78.463], [5.973, 61.454], [0, 31.428], [17.009, 5.973], [47.035, 0], [72.49, 17.009]];  // primary outline, 8 points, counter clockwise
void_1 = [[48.47, 43.058], [43.058, 48.47], [35.404, 48.47], [29.992, 43.058], [29.992, 35.404], [35.404, 29.992], [43.058, 29.992], [48.47, 35.404]];  // centre bore, 8 points
void_2 = [[65.955, 45.342], [63.791, 47.507], [60.729, 47.507], [58.564, 45.342], [58.564, 42.281], [60.729, 40.116], [63.791, 40.116], [65.955, 42.281]];  // bolt window 1, 8 points
void_3 = [[38.346, 63.791], [36.181, 65.955], [33.12, 65.955], [30.955, 63.791], [30.955, 60.729], [33.12, 58.564], [36.181, 58.564], [38.346, 60.729]];  // bolt window 2, 8 points
void_4 = [[19.898, 36.181], [17.733, 38.346], [14.671, 38.346], [12.507, 36.181], [12.507, 33.12], [14.671, 30.955], [17.733, 30.955], [19.898, 33.12]];  // bolt window 3, 8 points
void_5 = [[47.507, 17.733], [45.342, 19.898], [42.281, 19.898], [40.116, 17.733], [40.116, 14.671], [42.281, 12.507], [45.342, 12.507], [47.507, 14.671]];  // bolt window 4, 8 points

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
