$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 6-gon R35, 4 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 6;                // number of polygon sides
plate_r = 35;             // circumscribed radius of the polygon
bore_r = 10;              // centre bore radius
bolts = 4;                // number of bolt windows
ring_r = 25.11;           // bolt-circle radius
bolt_r = 4;               // bolt window radius
plate_t = 5;              // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[70, 30.311], [52.5, 60.622], [17.5, 60.622], [0, 30.311], [17.5, 0], [52.5, 0]];  // primary outline, 6 points, counter clockwise
void_1 = [[44.239, 34.138], [38.827, 39.55], [31.173, 39.55], [25.761, 34.138], [25.761, 26.484], [31.173, 21.072], [38.827, 21.072], [44.239, 26.484]];  // centre bore, 8 points
void_2 = [[63.806, 31.842], [61.641, 34.007], [58.579, 34.007], [56.414, 31.842], [56.414, 28.78], [58.579, 26.615], [61.641, 26.615], [63.806, 28.78]];  // bolt window 1, 8 points
void_3 = [[38.696, 56.952], [36.531, 59.117], [33.469, 59.117], [31.304, 56.952], [31.304, 53.89], [33.469, 51.725], [36.531, 51.725], [38.696, 53.89]];  // bolt window 2, 8 points
void_4 = [[13.586, 31.842], [11.421, 34.007], [8.359, 34.007], [6.194, 31.842], [6.194, 28.78], [8.359, 26.615], [11.421, 26.615], [13.586, 28.78]];  // bolt window 3, 8 points
void_5 = [[38.696, 6.732], [36.531, 8.897], [33.469, 8.897], [31.304, 6.732], [31.304, 3.67], [33.469, 1.505], [36.531, 1.505], [38.696, 3.67]];  // bolt window 4, 8 points

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
