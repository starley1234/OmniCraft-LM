$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 8-gon R40, 4 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 8;                // number of polygon sides
plate_r = 40;             // circumscribed radius of the polygon
bore_r = 10;              // centre bore radius
bolts = 4;                // number of bolt windows
ring_r = 23.48;           // bolt-circle radius
bolt_r = 4;               // bolt window radius
plate_t = 6;              // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[80, 40], [68.284, 68.284], [40, 80], [11.716, 68.284], [0, 40], [11.716, 11.716], [40, 0], [68.284, 11.716]];  // primary outline, 8 points, counter clockwise
void_1 = [[49.239, 43.827], [43.827, 49.239], [36.173, 49.239], [30.761, 43.827], [30.761, 36.173], [36.173, 30.761], [43.827, 30.761], [49.239, 36.173]];  // centre bore, 8 points
void_2 = [[67.176, 41.531], [65.011, 43.696], [61.949, 43.696], [59.784, 41.531], [59.784, 38.469], [61.949, 36.304], [65.011, 36.304], [67.176, 38.469]];  // bolt window 1, 8 points
void_3 = [[43.696, 65.011], [41.531, 67.176], [38.469, 67.176], [36.304, 65.011], [36.304, 61.949], [38.469, 59.784], [41.531, 59.784], [43.696, 61.949]];  // bolt window 2, 8 points
void_4 = [[20.216, 41.531], [18.051, 43.696], [14.989, 43.696], [12.824, 41.531], [12.824, 38.469], [14.989, 36.304], [18.051, 36.304], [20.216, 38.469]];  // bolt window 3, 8 points
void_5 = [[43.696, 18.051], [41.531, 20.216], [38.469, 20.216], [36.304, 18.051], [36.304, 14.989], [38.469, 12.824], [41.531, 12.824], [43.696, 14.989]];  // bolt window 4, 8 points

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
