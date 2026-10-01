$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 8-gon R40, 6 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 8;                // number of polygon sides
plate_r = 40;             // circumscribed radius of the polygon
bore_r = 8;               // centre bore radius
bolts = 6;                // number of bolt windows
ring_r = 22.48;           // bolt-circle radius
bolt_r = 3;               // bolt window radius
plate_t = 10;             // plate thickness, Z (extrusion height)
fit_tol = 0.02;           // declared fit tolerance (prompt contract)
free_tol = 0.2;           // declared free tolerance (prompt contract)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[78.463, 47.035], [61.454, 72.49], [31.428, 78.463], [5.973, 61.454], [0, 31.428], [17.009, 5.973], [47.035, 0], [72.49, 17.009]];  // primary outline, 8 points, counter clockwise
void_1 = [[46.622, 42.292], [42.292, 46.622], [36.17, 46.622], [31.84, 42.292], [31.84, 36.17], [36.17, 31.84], [42.292, 31.84], [46.622, 36.17]];  // centre bore, 8 points
void_2 = [[64.051, 44.765], [62.427, 46.388], [60.131, 46.388], [58.507, 44.765], [58.507, 42.469], [60.131, 40.845], [62.427, 40.845], [64.051, 42.469]];  // bolt window 1, 8 points
void_3 = [[49.229, 61.666], [47.605, 63.29], [45.309, 63.29], [43.685, 61.666], [43.685, 59.37], [45.309, 57.746], [47.605, 57.746], [49.229, 59.37]];  // bolt window 2, 8 points
void_4 = [[27.181, 57.28], [25.557, 58.904], [23.261, 58.904], [21.637, 57.28], [21.637, 54.984], [23.261, 53.361], [25.557, 53.361], [27.181, 54.984]];  // bolt window 3, 8 points
void_5 = [[19.955, 35.993], [18.331, 37.617], [16.035, 37.617], [14.411, 35.993], [14.411, 33.697], [16.035, 32.074], [18.331, 32.074], [19.955, 33.697]];  // bolt window 4, 8 points
void_6 = [[34.777, 19.092], [33.153, 20.716], [30.857, 20.716], [29.233, 19.092], [29.233, 16.796], [30.857, 15.172], [33.153, 15.172], [34.777, 16.796]];  // bolt window 5, 8 points
void_7 = [[56.825, 23.478], [55.201, 25.101], [52.905, 25.101], [51.281, 23.478], [51.281, 21.182], [52.905, 19.558], [55.201, 19.558], [56.825, 21.182]];  // bolt window 6, 8 points

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
