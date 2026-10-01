$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 8-gon R40, 3 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 8;                // number of polygon sides
plate_r = 40;             // circumscribed radius of the polygon
bore_r = 6;               // centre bore radius
bolts = 3;                // number of bolt windows
ring_r = 21.48;           // bolt-circle radius
bolt_r = 4;               // bolt window radius
plate_t = 6;              // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[80, 40], [68.284, 68.284], [40, 80], [11.716, 68.284], [0, 40], [11.716, 11.716], [40, 0], [68.284, 11.716]];  // primary outline, 8 points, counter clockwise
void_1 = [[45.543, 42.296], [42.296, 45.543], [37.704, 45.543], [34.457, 42.296], [34.457, 37.704], [37.704, 34.457], [42.296, 34.457], [45.543, 37.704]];  // centre bore, 8 points
void_2 = [[65.176, 41.531], [63.011, 43.696], [59.949, 43.696], [57.784, 41.531], [57.784, 38.469], [59.949, 36.304], [63.011, 36.304], [65.176, 38.469]];  // bolt window 1, 8 points
void_3 = [[32.956, 60.133], [30.791, 62.298], [27.729, 62.298], [25.564, 60.133], [25.564, 57.071], [27.729, 54.907], [30.791, 54.907], [32.956, 57.071]];  // bolt window 2, 8 points
void_4 = [[32.956, 22.929], [30.791, 25.093], [27.729, 25.093], [25.564, 22.929], [25.564, 19.867], [27.729, 17.702], [30.791, 17.702], [32.956, 19.867]];  // bolt window 3, 8 points

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
