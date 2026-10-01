$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 8-gon R25, 6 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 8;                // number of polygon sides
plate_r = 25;             // circumscribed radius of the polygon
bore_r = 10;              // centre bore radius
bolts = 6;                // number of bolt windows
ring_r = 16.55;           // bolt-circle radius
bolt_r = 2.5;             // bolt window radius
plate_t = 10;             // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[50, 25], [42.678, 42.678], [25, 50], [7.322, 42.678], [0, 25], [7.322, 7.322], [25, 0], [42.678, 7.322]];  // primary outline, 8 points, counter clockwise
void_1 = [[34.239, 28.827], [28.827, 34.239], [21.173, 34.239], [15.761, 28.827], [15.761, 21.173], [21.173, 15.761], [28.827, 15.761], [34.239, 21.173]];  // centre bore, 8 points
void_2 = [[43.86, 25.957], [42.507, 27.31], [40.593, 27.31], [39.24, 25.957], [39.24, 24.043], [40.593, 22.69], [42.507, 22.69], [43.86, 24.043]];  // bolt window 1, 8 points
void_3 = [[35.585, 40.289], [34.232, 41.642], [32.318, 41.642], [30.965, 40.289], [30.965, 38.376], [32.318, 37.023], [34.232, 37.023], [35.585, 38.376]];  // bolt window 2, 8 points
void_4 = [[19.035, 40.289], [17.682, 41.642], [15.768, 41.642], [14.415, 40.289], [14.415, 38.376], [15.768, 37.023], [17.682, 37.023], [19.035, 38.376]];  // bolt window 3, 8 points
void_5 = [[10.76, 25.957], [9.407, 27.31], [7.493, 27.31], [6.14, 25.957], [6.14, 24.043], [7.493, 22.69], [9.407, 22.69], [10.76, 24.043]];  // bolt window 4, 8 points
void_6 = [[19.035, 11.624], [17.682, 12.977], [15.768, 12.977], [14.415, 11.624], [14.415, 9.711], [15.768, 8.358], [17.682, 8.358], [19.035, 9.711]];  // bolt window 5, 8 points
void_7 = [[35.585, 11.624], [34.232, 12.977], [32.318, 12.977], [30.965, 11.624], [30.965, 9.711], [32.318, 8.358], [34.232, 8.358], [35.585, 9.711]];  // bolt window 6, 8 points

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
