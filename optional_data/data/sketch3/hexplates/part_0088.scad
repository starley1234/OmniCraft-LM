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
bolt_r = 3;               // bolt window radius
plate_t = 10;             // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[49.039, 29.397], [38.409, 45.306], [19.642, 49.039], [3.733, 38.409], [0, 19.642], [10.63, 3.733], [29.397, 0], [45.306, 10.63]];  // primary outline, 8 points, counter clockwise
void_1 = [[33.759, 28.347], [28.347, 33.759], [20.693, 33.759], [15.281, 28.347], [15.281, 20.693], [20.693, 15.281], [28.347, 15.281], [33.759, 20.693]];  // centre bore, 8 points
void_2 = [[43.524, 28.897], [41.9, 30.52], [39.604, 30.52], [37.98, 28.897], [37.98, 26.601], [39.604, 24.977], [41.9, 24.977], [43.524, 26.601]];  // bolt window 1, 8 points
void_3 = [[32.611, 41.34], [30.988, 42.963], [28.692, 42.963], [27.068, 41.34], [27.068, 39.044], [28.692, 37.42], [30.988, 37.42], [32.611, 39.044]];  // bolt window 2, 8 points
void_4 = [[16.379, 38.111], [14.756, 39.735], [12.46, 39.735], [10.836, 38.111], [10.836, 35.815], [12.46, 34.191], [14.756, 34.191], [16.379, 35.815]];  // bolt window 3, 8 points
void_5 = [[11.06, 22.439], [9.436, 24.063], [7.14, 24.063], [5.516, 22.439], [5.516, 20.143], [7.14, 18.52], [9.436, 18.52], [11.06, 20.143]];  // bolt window 4, 8 points
void_6 = [[21.972, 9.996], [20.348, 11.62], [18.052, 11.62], [16.429, 9.996], [16.429, 7.7], [18.052, 6.077], [20.348, 6.077], [21.972, 7.7]];  // bolt window 5, 8 points
void_7 = [[38.204, 13.225], [36.58, 14.849], [34.284, 14.849], [32.661, 13.225], [32.661, 10.929], [34.284, 9.305], [36.58, 9.305], [38.204, 10.929]];  // bolt window 6, 8 points

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
