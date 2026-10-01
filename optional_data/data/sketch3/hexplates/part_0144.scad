$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 8-gon R35, 4 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 8;                // number of polygon sides
plate_r = 35;             // circumscribed radius of the polygon
bore_r = 6;               // centre bore radius
bolts = 4;                // number of bolt windows
ring_r = 19.17;           // bolt-circle radius
bolt_r = 2.5;             // bolt window radius
plate_t = 6;              // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[68.655, 41.156], [53.772, 63.429], [27.499, 68.655], [5.226, 53.772], [0, 27.499], [14.883, 5.226], [41.156, 0], [63.429, 14.883]];  // primary outline, 8 points, counter clockwise
void_1 = [[39.87, 36.623], [36.623, 39.87], [32.031, 39.87], [28.784, 36.623], [28.784, 32.031], [32.031, 28.784], [36.623, 28.784], [39.87, 32.031]];  // centre bore, 8 points
void_2 = [[55.438, 39.024], [54.085, 40.377], [52.172, 40.377], [50.819, 39.024], [50.819, 37.11], [52.172, 35.757], [54.085, 35.757], [55.438, 37.11]];  // bolt window 1, 8 points
void_3 = [[32.897, 54.085], [31.544, 55.438], [29.63, 55.438], [28.277, 54.085], [28.277, 52.172], [29.63, 50.819], [31.544, 50.819], [32.897, 52.172]];  // bolt window 2, 8 points
void_4 = [[17.835, 31.544], [16.482, 32.897], [14.569, 32.897], [13.216, 31.544], [13.216, 29.63], [14.569, 28.277], [16.482, 28.277], [17.835, 29.63]];  // bolt window 3, 8 points
void_5 = [[40.377, 16.482], [39.024, 17.835], [37.11, 17.835], [35.757, 16.482], [35.757, 14.569], [37.11, 13.216], [39.024, 13.216], [40.377, 14.569]];  // bolt window 4, 8 points

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
