$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 6-gon R25, 4 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 6;                // number of polygon sides
plate_r = 25;             // circumscribed radius of the polygon
bore_r = 10;              // centre bore radius
bolts = 4;                // number of bolt windows
ring_r = 17.45;           // bolt-circle radius
bolt_r = 3;               // bolt window radius
plate_t = 5;              // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[48.296, 30.619], [30.619, 48.296], [6.47, 41.826], [0, 17.678], [17.678, 0], [41.826, 6.47]];  // primary outline, 6 points, counter clockwise
void_1 = [[33.387, 27.975], [27.975, 33.387], [20.321, 33.387], [14.909, 27.975], [14.909, 20.321], [20.321, 14.909], [27.975, 14.909], [33.387, 20.321]];  // centre bore, 8 points
void_2 = [[43.775, 29.812], [42.151, 31.436], [39.855, 31.436], [38.232, 29.812], [38.232, 27.516], [39.855, 25.893], [42.151, 25.893], [43.775, 27.516]];  // bolt window 1, 8 points
void_3 = [[22.403, 42.151], [20.78, 43.775], [18.484, 43.775], [16.86, 42.151], [16.86, 39.855], [18.484, 38.232], [20.78, 38.232], [22.403, 39.855]];  // bolt window 2, 8 points
void_4 = [[10.064, 20.78], [8.441, 22.403], [6.145, 22.403], [4.521, 20.78], [4.521, 18.484], [6.145, 16.86], [8.441, 16.86], [10.064, 18.484]];  // bolt window 3, 8 points
void_5 = [[31.436, 8.441], [29.812, 10.064], [27.516, 10.064], [25.893, 8.441], [25.893, 6.145], [27.516, 4.521], [29.812, 4.521], [31.436, 6.145]];  // bolt window 4, 8 points

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
