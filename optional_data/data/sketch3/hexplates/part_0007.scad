$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 8-gon R30, 4 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 8;                // number of polygon sides
plate_r = 30;             // circumscribed radius of the polygon
bore_r = 10;              // centre bore radius
bolts = 4;                // number of bolt windows
ring_r = 18.86;           // bolt-circle radius
bolt_r = 4;               // bolt window radius
plate_t = 8;              // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[60, 30], [51.213, 51.213], [30, 60], [8.787, 51.213], [0, 30], [8.787, 8.787], [30, 0], [51.213, 8.787]];  // primary outline, 8 points, counter clockwise
void_1 = [[39.239, 33.827], [33.827, 39.239], [26.173, 39.239], [20.761, 33.827], [20.761, 26.173], [26.173, 20.761], [33.827, 20.761], [39.239, 26.173]];  // centre bore, 8 points
void_2 = [[52.556, 31.531], [50.391, 33.696], [47.329, 33.696], [45.164, 31.531], [45.164, 28.469], [47.329, 26.304], [50.391, 26.304], [52.556, 28.469]];  // bolt window 1, 8 points
void_3 = [[33.696, 50.391], [31.531, 52.556], [28.469, 52.556], [26.304, 50.391], [26.304, 47.329], [28.469, 45.164], [31.531, 45.164], [33.696, 47.329]];  // bolt window 2, 8 points
void_4 = [[14.836, 31.531], [12.671, 33.696], [9.609, 33.696], [7.444, 31.531], [7.444, 28.469], [9.609, 26.304], [12.671, 26.304], [14.836, 28.469]];  // bolt window 3, 8 points
void_5 = [[33.696, 12.671], [31.531, 14.836], [28.469, 14.836], [26.304, 12.671], [26.304, 9.609], [28.469, 7.444], [31.531, 7.444], [33.696, 9.609]];  // bolt window 4, 8 points

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
