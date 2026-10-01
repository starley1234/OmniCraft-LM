$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 8-gon R40, 4 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 8;                // number of polygon sides
plate_r = 40;             // circumscribed radius of the polygon
bore_r = 8;               // centre bore radius
bolts = 4;                // number of bolt windows
ring_r = 22.48;           // bolt-circle radius
bolt_r = 4;               // bolt window radius
plate_t = 5;              // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[80, 40], [68.284, 68.284], [40, 80], [11.716, 68.284], [0, 40], [11.716, 11.716], [40, 0], [68.284, 11.716]];  // primary outline, 8 points, counter clockwise
void_1 = [[47.391, 43.061], [43.061, 47.391], [36.939, 47.391], [32.609, 43.061], [32.609, 36.939], [36.939, 32.609], [43.061, 32.609], [47.391, 36.939]];  // centre bore, 8 points
void_2 = [[66.176, 41.531], [64.011, 43.696], [60.949, 43.696], [58.784, 41.531], [58.784, 38.469], [60.949, 36.304], [64.011, 36.304], [66.176, 38.469]];  // bolt window 1, 8 points
void_3 = [[43.696, 64.011], [41.531, 66.176], [38.469, 66.176], [36.304, 64.011], [36.304, 60.949], [38.469, 58.784], [41.531, 58.784], [43.696, 60.949]];  // bolt window 2, 8 points
void_4 = [[21.216, 41.531], [19.051, 43.696], [15.989, 43.696], [13.824, 41.531], [13.824, 38.469], [15.989, 36.304], [19.051, 36.304], [21.216, 38.469]];  // bolt window 3, 8 points
void_5 = [[43.696, 19.051], [41.531, 21.216], [38.469, 21.216], [36.304, 19.051], [36.304, 15.989], [38.469, 13.824], [41.531, 13.824], [43.696, 15.989]];  // bolt window 4, 8 points

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
