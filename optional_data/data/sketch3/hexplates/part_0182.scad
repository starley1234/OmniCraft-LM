$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 6-gon R30, 3 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 6;                // number of polygon sides
plate_r = 30;             // circumscribed radius of the polygon
bore_r = 8;               // centre bore radius
bolts = 3;                // number of bolt windows
ring_r = 21.78;           // bolt-circle radius
bolt_r = 3;               // bolt window radius
plate_t = 6;              // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[60, 25.981], [45, 51.962], [15, 51.962], [0, 25.981], [15, 0], [45, 0]];  // primary outline, 6 points, counter clockwise
void_1 = [[37.391, 29.042], [33.061, 33.372], [26.939, 33.372], [22.609, 29.042], [22.609, 22.92], [26.939, 18.59], [33.061, 18.59], [37.391, 22.92]];  // centre bore, 8 points
void_2 = [[54.552, 27.129], [52.928, 28.753], [50.632, 28.753], [49.008, 27.129], [49.008, 24.833], [50.632, 23.209], [52.928, 23.209], [54.552, 24.833]];  // bolt window 1, 8 points
void_3 = [[21.882, 45.991], [20.258, 47.615], [17.962, 47.615], [16.338, 45.991], [16.338, 43.695], [17.962, 42.071], [20.258, 42.071], [21.882, 43.695]];  // bolt window 2, 8 points
void_4 = [[21.882, 8.267], [20.258, 9.891], [17.962, 9.891], [16.338, 8.267], [16.338, 5.971], [17.962, 4.347], [20.258, 4.347], [21.882, 5.971]];  // bolt window 3, 8 points

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
