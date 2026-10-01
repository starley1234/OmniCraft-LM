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
bolt_r = 2.5;             // bolt window radius
plate_t = 10;             // plate thickness, Z (extrusion height)
fit_tol = 0.05;           // declared fit tolerance (prompt contract)
free_tol = 0.2;           // declared free tolerance (prompt contract)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[49.039, 29.397], [38.409, 45.306], [19.642, 49.039], [3.733, 38.409], [0, 19.642], [10.63, 3.733], [29.397, 0], [45.306, 10.63]];  // primary outline, 8 points, counter clockwise
void_1 = [[30.063, 26.816], [26.816, 30.063], [22.224, 30.063], [18.977, 26.816], [18.977, 22.224], [22.224, 18.977], [26.816, 18.977], [30.063, 22.224]];  // centre bore, 8 points
void_2 = [[41.1, 28.315], [39.747, 29.668], [37.834, 29.668], [36.481, 28.315], [36.481, 26.402], [37.834, 25.049], [39.747, 25.049], [41.1, 26.402]];  // bolt window 1, 8 points
void_3 = [[23.991, 39.747], [22.638, 41.1], [20.725, 41.1], [19.372, 39.747], [19.372, 37.834], [20.725, 36.481], [22.638, 36.481], [23.991, 37.834]];  // bolt window 2, 8 points
void_4 = [[12.559, 22.638], [11.206, 23.991], [9.293, 23.991], [7.94, 22.638], [7.94, 20.725], [9.293, 19.372], [11.206, 19.372], [12.559, 20.725]];  // bolt window 3, 8 points
void_5 = [[29.668, 11.206], [28.315, 12.559], [26.402, 12.559], [25.049, 11.206], [25.049, 9.293], [26.402, 7.94], [28.315, 7.94], [29.668, 9.293]];  // bolt window 4, 8 points

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
