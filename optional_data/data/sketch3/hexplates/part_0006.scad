$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 8-gon R40, 6 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 8;                // number of polygon sides
plate_r = 40;             // circumscribed radius of the polygon
bore_r = 6;               // centre bore radius
bolts = 6;                // number of bolt windows
ring_r = 21.48;           // bolt-circle radius
bolt_r = 2.5;             // bolt window radius
plate_t = 6;              // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[80, 40], [68.284, 68.284], [40, 80], [11.716, 68.284], [0, 40], [11.716, 11.716], [40, 0], [68.284, 11.716]];  // primary outline, 8 points, counter clockwise
void_1 = [[45.543, 42.296], [42.296, 45.543], [37.704, 45.543], [34.457, 42.296], [34.457, 37.704], [37.704, 34.457], [42.296, 34.457], [45.543, 37.704]];  // centre bore, 8 points
void_2 = [[63.79, 40.957], [62.437, 42.31], [60.523, 42.31], [59.17, 40.957], [59.17, 39.043], [60.523, 37.69], [62.437, 37.69], [63.79, 39.043]];  // bolt window 1, 8 points
void_3 = [[53.05, 59.559], [51.697, 60.912], [49.783, 60.912], [48.43, 59.559], [48.43, 57.646], [49.783, 56.293], [51.697, 56.293], [53.05, 57.646]];  // bolt window 2, 8 points
void_4 = [[31.57, 59.559], [30.217, 60.912], [28.303, 60.912], [26.95, 59.559], [26.95, 57.646], [28.303, 56.293], [30.217, 56.293], [31.57, 57.646]];  // bolt window 3, 8 points
void_5 = [[20.83, 40.957], [19.477, 42.31], [17.563, 42.31], [16.21, 40.957], [16.21, 39.043], [17.563, 37.69], [19.477, 37.69], [20.83, 39.043]];  // bolt window 4, 8 points
void_6 = [[31.57, 22.354], [30.217, 23.707], [28.303, 23.707], [26.95, 22.354], [26.95, 20.441], [28.303, 19.088], [30.217, 19.088], [31.57, 20.441]];  // bolt window 5, 8 points
void_7 = [[53.05, 22.354], [51.697, 23.707], [49.783, 23.707], [48.43, 22.354], [48.43, 20.441], [49.783, 19.088], [51.697, 19.088], [53.05, 20.441]];  // bolt window 6, 8 points

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
