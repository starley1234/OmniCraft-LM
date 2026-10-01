$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 6-gon R35, 3 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 6;                // number of polygon sides
plate_r = 35;             // circumscribed radius of the polygon
bore_r = 8;               // centre bore radius
bolts = 3;                // number of bolt windows
ring_r = 25.11;           // bolt-circle radius
bolt_r = 4;               // bolt window radius
plate_t = 8;              // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[67.615, 42.866], [42.866, 67.615], [9.059, 58.556], [0, 24.749], [24.749, 0], [58.556, 9.059]];  // primary outline, 6 points, counter clockwise
void_1 = [[41.198, 36.868], [36.868, 41.198], [30.746, 41.198], [26.416, 36.868], [26.416, 30.746], [30.746, 26.416], [36.868, 26.416], [41.198, 30.746]];  // centre bore, 8 points
void_2 = [[61.757, 41.837], [59.592, 44.001], [56.531, 44.001], [54.366, 41.837], [54.366, 38.775], [56.531, 36.61], [59.592, 36.61], [61.757, 38.775]];  // bolt window 1, 8 points
void_3 = [[19.747, 53.093], [17.582, 55.258], [14.521, 55.258], [12.356, 53.093], [12.356, 50.032], [14.521, 47.867], [17.582, 47.867], [19.747, 50.032]];  // bolt window 2, 8 points
void_4 = [[31.004, 11.083], [28.839, 13.248], [25.777, 13.248], [23.613, 11.083], [23.613, 8.022], [25.777, 5.857], [28.839, 5.857], [31.004, 8.022]];  // bolt window 3, 8 points

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
