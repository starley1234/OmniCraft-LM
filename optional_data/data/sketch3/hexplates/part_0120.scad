$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 8-gon R35, 6 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 8;                // number of polygon sides
plate_r = 35;             // circumscribed radius of the polygon
bore_r = 8;               // centre bore radius
bolts = 6;                // number of bolt windows
ring_r = 20.17;           // bolt-circle radius
bolt_r = 2.5;             // bolt window radius
plate_t = 6;              // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[70, 35], [59.749, 59.749], [35, 70], [10.251, 59.749], [0, 35], [10.251, 10.251], [35, 0], [59.749, 10.251]];  // primary outline, 8 points, counter clockwise
void_1 = [[42.391, 38.061], [38.061, 42.391], [31.939, 42.391], [27.609, 38.061], [27.609, 31.939], [31.939, 27.609], [38.061, 27.609], [42.391, 31.939]];  // centre bore, 8 points
void_2 = [[57.48, 35.957], [56.127, 37.31], [54.213, 37.31], [52.86, 35.957], [52.86, 34.043], [54.213, 32.69], [56.127, 32.69], [57.48, 34.043]];  // bolt window 1, 8 points
void_3 = [[47.395, 53.424], [46.042, 54.777], [44.128, 54.777], [42.775, 53.424], [42.775, 51.511], [44.128, 50.158], [46.042, 50.158], [47.395, 51.511]];  // bolt window 2, 8 points
void_4 = [[27.225, 53.424], [25.872, 54.777], [23.958, 54.777], [22.605, 53.424], [22.605, 51.511], [23.958, 50.158], [25.872, 50.158], [27.225, 51.511]];  // bolt window 3, 8 points
void_5 = [[17.14, 35.957], [15.787, 37.31], [13.873, 37.31], [12.52, 35.957], [12.52, 34.043], [13.873, 32.69], [15.787, 32.69], [17.14, 34.043]];  // bolt window 4, 8 points
void_6 = [[27.225, 18.489], [25.872, 19.842], [23.958, 19.842], [22.605, 18.489], [22.605, 16.576], [23.958, 15.223], [25.872, 15.223], [27.225, 16.576]];  // bolt window 5, 8 points
void_7 = [[47.395, 18.489], [46.042, 19.842], [44.128, 19.842], [42.775, 18.489], [42.775, 16.576], [44.128, 15.223], [46.042, 15.223], [47.395, 16.576]];  // bolt window 6, 8 points

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
