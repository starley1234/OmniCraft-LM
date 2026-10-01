$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 6-gon R35, 3 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 6;                // number of polygon sides
plate_r = 35;             // circumscribed radius of the polygon
bore_r = 6;               // centre bore radius
bolts = 3;                // number of bolt windows
ring_r = 25.11;           // bolt-circle radius
bolt_r = 4;               // bolt window radius
plate_t = 10;             // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[70, 30.311], [52.5, 60.622], [17.5, 60.622], [0, 30.311], [17.5, 0], [52.5, 0]];  // primary outline, 6 points, counter clockwise
void_1 = [[40.543, 32.607], [37.296, 35.854], [32.704, 35.854], [29.457, 32.607], [29.457, 28.015], [32.704, 24.768], [37.296, 24.768], [40.543, 28.015]];  // centre bore, 8 points
void_2 = [[63.806, 31.842], [61.641, 34.007], [58.579, 34.007], [56.414, 31.842], [56.414, 28.78], [58.579, 26.615], [61.641, 26.615], [63.806, 28.78]];  // bolt window 1, 8 points
void_3 = [[26.141, 53.588], [23.976, 55.752], [20.914, 55.752], [18.749, 53.588], [18.749, 50.526], [20.914, 48.361], [23.976, 48.361], [26.141, 50.526]];  // bolt window 2, 8 points
void_4 = [[26.141, 10.096], [23.976, 12.261], [20.914, 12.261], [18.749, 10.096], [18.749, 7.034], [20.914, 4.87], [23.976, 4.87], [26.141, 7.034]];  // bolt window 3, 8 points

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
