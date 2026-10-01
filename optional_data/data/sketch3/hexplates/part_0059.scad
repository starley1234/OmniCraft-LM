$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 6-gon R40, 6 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 6;                // number of polygon sides
plate_r = 40;             // circumscribed radius of the polygon
bore_r = 8;               // centre bore radius
bolts = 6;                // number of bolt windows
ring_r = 29.44;           // bolt-circle radius
bolt_r = 4;               // bolt window radius
plate_t = 5;              // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[77.274, 48.99], [48.99, 77.274], [10.353, 66.921], [0, 28.284], [28.284, 0], [66.921, 10.353]];  // primary outline, 6 points, counter clockwise
void_1 = [[46.028, 41.698], [41.698, 46.028], [35.576, 46.028], [31.246, 41.698], [31.246, 35.576], [35.576, 31.246], [41.698, 31.246], [46.028, 35.576]];  // centre bore, 8 points
void_2 = [[70.769, 47.787], [68.605, 49.952], [65.543, 49.952], [63.378, 47.787], [63.378, 44.726], [65.543, 42.561], [68.605, 42.561], [70.769, 44.726]];  // bolt window 1, 8 points
void_3 = [[49.952, 68.605], [47.787, 70.769], [44.726, 70.769], [42.561, 68.605], [42.561, 65.543], [44.726, 63.378], [47.787, 63.378], [49.952, 65.543]];  // bolt window 2, 8 points
void_4 = [[21.515, 60.985], [19.351, 63.15], [16.289, 63.15], [14.124, 60.985], [14.124, 57.923], [16.289, 55.759], [19.351, 55.759], [21.515, 57.923]];  // bolt window 3, 8 points
void_5 = [[13.896, 32.548], [11.731, 34.713], [8.669, 34.713], [6.505, 32.548], [6.505, 29.487], [8.669, 27.322], [11.731, 27.322], [13.896, 29.487]];  // bolt window 4, 8 points
void_6 = [[34.713, 11.731], [32.548, 13.896], [29.487, 13.896], [27.322, 11.731], [27.322, 8.669], [29.487, 6.505], [32.548, 6.505], [34.713, 8.669]];  // bolt window 5, 8 points
void_7 = [[63.15, 19.351], [60.985, 21.515], [57.923, 21.515], [55.759, 19.351], [55.759, 16.289], [57.923, 14.124], [60.985, 14.124], [63.15, 16.289]];  // bolt window 6, 8 points

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
