$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 6-gon R35, 4 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 6;                // number of polygon sides
plate_r = 35;             // circumscribed radius of the polygon
bore_r = 6;               // centre bore radius
bolts = 4;                // number of bolt windows
ring_r = 26.11;           // bolt-circle radius
bolt_r = 3;               // bolt window radius
plate_t = 8;              // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[70, 30.311], [52.5, 60.622], [17.5, 60.622], [0, 30.311], [17.5, 0], [52.5, 0]];  // primary outline, 6 points, counter clockwise
void_1 = [[40.543, 32.607], [37.296, 35.854], [32.704, 35.854], [29.457, 32.607], [29.457, 28.015], [32.704, 24.768], [37.296, 24.768], [40.543, 28.015]];  // centre bore, 8 points
void_2 = [[63.882, 31.459], [62.258, 33.083], [59.962, 33.083], [58.338, 31.459], [58.338, 29.163], [59.962, 27.539], [62.258, 27.539], [63.882, 29.163]];  // bolt window 1, 8 points
void_3 = [[37.772, 57.569], [36.148, 59.193], [33.852, 59.193], [32.228, 57.569], [32.228, 55.273], [33.852, 53.649], [36.148, 53.649], [37.772, 55.273]];  // bolt window 2, 8 points
void_4 = [[11.662, 31.459], [10.038, 33.083], [7.742, 33.083], [6.118, 31.459], [6.118, 29.163], [7.742, 27.539], [10.038, 27.539], [11.662, 29.163]];  // bolt window 3, 8 points
void_5 = [[37.772, 5.349], [36.148, 6.973], [33.852, 6.973], [32.228, 5.349], [32.228, 3.053], [33.852, 1.429], [36.148, 1.429], [37.772, 3.053]];  // bolt window 4, 8 points

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
