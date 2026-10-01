$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 8-gon R25, 3 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 8;                // number of polygon sides
plate_r = 25;             // circumscribed radius of the polygon
bore_r = 8;               // centre bore radius
bolts = 3;                // number of bolt windows
ring_r = 15.55;           // bolt-circle radius
bolt_r = 2.5;             // bolt window radius
plate_t = 6;              // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[49.039, 29.397], [38.409, 45.306], [19.642, 49.039], [3.733, 38.409], [0, 19.642], [10.63, 3.733], [29.397, 0], [45.306, 10.63]];  // primary outline, 8 points, counter clockwise
void_1 = [[31.911, 27.581], [27.581, 31.911], [21.459, 31.911], [17.129, 27.581], [17.129, 21.459], [21.459, 17.129], [27.581, 17.129], [31.911, 21.459]];  // centre bore, 8 points
void_2 = [[42.081, 28.51], [40.728, 29.863], [38.815, 29.863], [37.462, 28.51], [37.462, 26.597], [38.815, 25.244], [40.728, 25.244], [42.081, 26.597]];  // bolt window 1, 8 points
void_3 = [[16.577, 37.168], [15.224, 38.521], [13.31, 38.521], [11.957, 37.168], [11.957, 35.254], [13.31, 33.901], [15.224, 33.901], [16.577, 35.254]];  // bolt window 2, 8 points
void_4 = [[21.831, 10.752], [20.478, 12.105], [18.565, 12.105], [17.212, 10.752], [17.212, 8.839], [18.565, 7.486], [20.478, 7.486], [21.831, 8.839]];  // bolt window 3, 8 points

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
