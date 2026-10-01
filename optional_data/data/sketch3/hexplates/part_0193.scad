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
bolt_r = 2.5;             // bolt window radius
plate_t = 10;             // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[80, 40], [68.284, 68.284], [40, 80], [11.716, 68.284], [0, 40], [11.716, 11.716], [40, 0], [68.284, 11.716]];  // primary outline, 8 points, counter clockwise
void_1 = [[45.543, 42.296], [42.296, 45.543], [37.704, 45.543], [34.457, 42.296], [34.457, 37.704], [37.704, 34.457], [42.296, 34.457], [45.543, 37.704]];  // centre bore, 8 points
void_2 = [[63.79, 40.957], [62.437, 42.31], [60.523, 42.31], [59.17, 40.957], [59.17, 39.043], [60.523, 37.69], [62.437, 37.69], [63.79, 39.043]];  // bolt window 1, 8 points
void_3 = [[31.57, 59.559], [30.217, 60.912], [28.303, 60.912], [26.95, 59.559], [26.95, 57.646], [28.303, 56.293], [30.217, 56.293], [31.57, 57.646]];  // bolt window 2, 8 points
void_4 = [[31.57, 22.354], [30.217, 23.707], [28.303, 23.707], [26.95, 22.354], [26.95, 20.441], [28.303, 19.088], [30.217, 19.088], [31.57, 20.441]];  // bolt window 3, 8 points

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
