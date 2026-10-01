$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 8-gon R40, 4 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 8;                // number of polygon sides
plate_r = 40;             // circumscribed radius of the polygon
bore_r = 6;               // centre bore radius
bolts = 4;                // number of bolt windows
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
void_3 = [[43.696, 63.011], [41.531, 65.176], [38.469, 65.176], [36.304, 63.011], [36.304, 59.949], [38.469, 57.784], [41.531, 57.784], [43.696, 59.949]];  // bolt window 2, 8 points
void_4 = [[22.216, 41.531], [20.051, 43.696], [16.989, 43.696], [14.824, 41.531], [14.824, 38.469], [16.989, 36.304], [20.051, 36.304], [22.216, 38.469]];  // bolt window 3, 8 points
void_5 = [[43.696, 20.051], [41.531, 22.216], [38.469, 22.216], [36.304, 20.051], [36.304, 16.989], [38.469, 14.824], [41.531, 14.824], [43.696, 16.989]];  // bolt window 4, 8 points

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
