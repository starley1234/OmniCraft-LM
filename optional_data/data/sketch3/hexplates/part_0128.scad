$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 8-gon R40, 4 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 8;                // number of polygon sides
plate_r = 40;             // circumscribed radius of the polygon
bore_r = 8;               // centre bore radius
bolts = 4;                // number of bolt windows
ring_r = 22.48;           // bolt-circle radius
bolt_r = 4;               // bolt window radius
plate_t = 6;              // plate thickness, Z (extrusion height)
fit_tol = 0.1;            // declared fit tolerance (prompt contract)
free_tol = 0.3;           // declared free tolerance (prompt contract)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[78.463, 47.035], [61.454, 72.49], [31.428, 78.463], [5.973, 61.454], [0, 31.428], [17.009, 5.973], [47.035, 0], [72.49, 17.009]];  // primary outline, 8 points, counter clockwise
void_1 = [[46.622, 42.292], [42.292, 46.622], [36.17, 46.622], [31.84, 42.292], [31.84, 36.17], [36.17, 31.84], [42.292, 31.84], [46.622, 36.17]];  // centre bore, 8 points
void_2 = [[64.975, 45.147], [62.81, 47.312], [59.748, 47.312], [57.584, 45.147], [57.584, 42.086], [59.748, 39.921], [62.81, 39.921], [64.975, 42.086]];  // bolt window 1, 8 points
void_3 = [[38.541, 62.81], [36.376, 64.975], [33.315, 64.975], [31.15, 62.81], [31.15, 59.748], [33.315, 57.584], [36.376, 57.584], [38.541, 59.748]];  // bolt window 2, 8 points
void_4 = [[20.878, 36.376], [18.714, 38.541], [15.652, 38.541], [13.487, 36.376], [13.487, 33.315], [15.652, 31.15], [18.714, 31.15], [20.878, 33.315]];  // bolt window 3, 8 points
void_5 = [[47.312, 18.714], [45.147, 20.878], [42.086, 20.878], [39.921, 18.714], [39.921, 15.652], [42.086, 13.487], [45.147, 13.487], [47.312, 15.652]];  // bolt window 4, 8 points

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
