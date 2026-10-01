$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 6-gon R40, 3 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 6;                // number of polygon sides
plate_r = 40;             // circumscribed radius of the polygon
bore_r = 10;              // centre bore radius
bolts = 3;                // number of bolt windows
ring_r = 29.44;           // bolt-circle radius
bolt_r = 4;               // bolt window radius
plate_t = 5;              // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[77.274, 48.99], [48.99, 77.274], [10.353, 66.921], [0, 28.284], [28.284, 0], [66.921, 10.353]];  // primary outline, 6 points, counter clockwise
void_1 = [[47.876, 42.464], [42.464, 47.876], [34.81, 47.876], [29.398, 42.464], [29.398, 34.81], [34.81, 29.398], [42.464, 29.398], [47.876, 34.81]];  // centre bore, 8 points
void_2 = [[70.769, 47.787], [68.605, 49.952], [65.543, 49.952], [63.378, 47.787], [63.378, 44.726], [65.543, 42.561], [68.605, 42.561], [70.769, 44.726]];  // bolt window 1, 8 points
void_3 = [[21.515, 60.985], [19.351, 63.15], [16.289, 63.15], [14.124, 60.985], [14.124, 57.923], [16.289, 55.759], [19.351, 55.759], [21.515, 57.923]];  // bolt window 2, 8 points
void_4 = [[34.713, 11.731], [32.548, 13.896], [29.487, 13.896], [27.322, 11.731], [27.322, 8.669], [29.487, 6.505], [32.548, 6.505], [34.713, 8.669]];  // bolt window 3, 8 points

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
