$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 6-gon R35, 3 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 6;                // number of polygon sides
plate_r = 35;             // circumscribed radius of the polygon
bore_r = 8;               // centre bore radius
bolts = 3;                // number of bolt windows
ring_r = 26.11;           // bolt-circle radius
bolt_r = 3;               // bolt window radius
plate_t = 10;             // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[70, 30.311], [52.5, 60.622], [17.5, 60.622], [0, 30.311], [17.5, 0], [52.5, 0]];  // primary outline, 6 points, counter clockwise
void_1 = [[42.391, 33.372], [38.061, 37.702], [31.939, 37.702], [27.609, 33.372], [27.609, 27.25], [31.939, 22.92], [38.061, 22.92], [42.391, 27.25]];  // centre bore, 8 points
void_2 = [[63.882, 31.459], [62.258, 33.083], [59.962, 33.083], [58.338, 31.459], [58.338, 29.163], [59.962, 27.539], [62.258, 27.539], [63.882, 29.163]];  // bolt window 1, 8 points
void_3 = [[24.717, 54.071], [23.093, 55.695], [20.797, 55.695], [19.173, 54.071], [19.173, 51.775], [20.797, 50.151], [23.093, 50.151], [24.717, 51.775]];  // bolt window 2, 8 points
void_4 = [[24.717, 8.847], [23.093, 10.471], [20.797, 10.471], [19.173, 8.847], [19.173, 6.551], [20.797, 4.927], [23.093, 4.927], [24.717, 6.551]];  // bolt window 3, 8 points

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
