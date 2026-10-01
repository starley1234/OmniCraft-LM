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
bolt_r = 3;               // bolt window radius
plate_t = 10;             // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[80, 40], [68.284, 68.284], [40, 80], [11.716, 68.284], [0, 40], [11.716, 11.716], [40, 0], [68.284, 11.716]];  // primary outline, 8 points, counter clockwise
void_1 = [[47.391, 43.061], [43.061, 47.391], [36.939, 47.391], [32.609, 43.061], [32.609, 36.939], [36.939, 32.609], [43.061, 32.609], [47.391, 36.939]];  // centre bore, 8 points
void_2 = [[65.252, 41.148], [63.628, 42.772], [61.332, 42.772], [59.708, 41.148], [59.708, 38.852], [61.332, 37.228], [63.628, 37.228], [65.252, 38.852]];  // bolt window 1, 8 points
void_3 = [[42.772, 63.628], [41.148, 65.252], [38.852, 65.252], [37.228, 63.628], [37.228, 61.332], [38.852, 59.708], [41.148, 59.708], [42.772, 61.332]];  // bolt window 2, 8 points
void_4 = [[20.292, 41.148], [18.668, 42.772], [16.372, 42.772], [14.748, 41.148], [14.748, 38.852], [16.372, 37.228], [18.668, 37.228], [20.292, 38.852]];  // bolt window 3, 8 points
void_5 = [[42.772, 18.668], [41.148, 20.292], [38.852, 20.292], [37.228, 18.668], [37.228, 16.372], [38.852, 14.748], [41.148, 14.748], [42.772, 16.372]];  // bolt window 4, 8 points

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
