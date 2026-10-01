$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 8-gon R25, 4 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 8;                // number of polygon sides
plate_r = 25;             // circumscribed radius of the polygon
bore_r = 10;              // centre bore radius
bolts = 4;                // number of bolt windows
ring_r = 16.55;           // bolt-circle radius
bolt_r = 4;               // bolt window radius
plate_t = 10;             // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[49.039, 29.397], [38.409, 45.306], [19.642, 49.039], [3.733, 38.409], [0, 19.642], [10.63, 3.733], [29.397, 0], [45.306, 10.63]];  // primary outline, 8 points, counter clockwise
void_1 = [[33.759, 28.347], [28.347, 33.759], [20.693, 33.759], [15.281, 28.347], [15.281, 20.693], [20.693, 15.281], [28.347, 15.281], [33.759, 20.693]];  // centre bore, 8 points
void_2 = [[44.448, 29.279], [42.283, 31.444], [39.221, 31.444], [37.056, 29.279], [37.056, 26.218], [39.221, 24.053], [42.283, 24.053], [44.448, 26.218]];  // bolt window 1, 8 points
void_3 = [[24.987, 42.283], [22.822, 44.448], [19.761, 44.448], [17.596, 42.283], [17.596, 39.221], [19.761, 37.056], [22.822, 37.056], [24.987, 39.221]];  // bolt window 2, 8 points
void_4 = [[11.984, 22.822], [9.819, 24.987], [6.757, 24.987], [4.592, 22.822], [4.592, 19.761], [6.757, 17.596], [9.819, 17.596], [11.984, 19.761]];  // bolt window 3, 8 points
void_5 = [[31.444, 9.819], [29.279, 11.984], [26.218, 11.984], [24.053, 9.819], [24.053, 6.757], [26.218, 4.592], [29.279, 4.592], [31.444, 6.757]];  // bolt window 4, 8 points

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
