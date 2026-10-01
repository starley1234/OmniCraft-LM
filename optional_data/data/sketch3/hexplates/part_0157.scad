$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 8-gon R40, 6 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 8;                // number of polygon sides
plate_r = 40;             // circumscribed radius of the polygon
bore_r = 10;              // centre bore radius
bolts = 6;                // number of bolt windows
ring_r = 23.48;           // bolt-circle radius
bolt_r = 2.5;             // bolt window radius
plate_t = 8;              // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[78.463, 47.035], [61.454, 72.49], [31.428, 78.463], [5.973, 61.454], [0, 31.428], [17.009, 5.973], [47.035, 0], [72.49, 17.009]];  // primary outline, 8 points, counter clockwise
void_1 = [[48.47, 43.058], [43.058, 48.47], [35.404, 48.47], [29.992, 43.058], [29.992, 35.404], [35.404, 29.992], [43.058, 29.992], [48.47, 35.404]];  // centre bore, 8 points
void_2 = [[64.57, 44.768], [63.217, 46.121], [61.303, 46.121], [59.95, 44.768], [59.95, 42.855], [61.303, 41.502], [63.217, 41.502], [64.57, 42.855]];  // bolt window 1, 8 points
void_3 = [[49.088, 62.422], [47.735, 63.775], [45.822, 63.775], [44.469, 62.422], [44.469, 60.508], [45.822, 59.155], [47.735, 59.155], [49.088, 60.508]];  // bolt window 2, 8 points
void_4 = [[26.059, 57.841], [24.706, 59.194], [22.793, 59.194], [21.44, 57.841], [21.44, 55.927], [22.793, 54.574], [24.706, 54.574], [26.059, 55.927]];  // bolt window 3, 8 points
void_5 = [[18.512, 35.607], [17.159, 36.96], [15.245, 36.96], [13.892, 35.607], [13.892, 33.694], [15.245, 32.341], [17.159, 32.341], [18.512, 33.694]];  // bolt window 4, 8 points
void_6 = [[33.993, 17.954], [32.64, 19.307], [30.727, 19.307], [29.374, 17.954], [29.374, 16.04], [30.727, 14.687], [32.64, 14.687], [33.993, 16.04]];  // bolt window 5, 8 points
void_7 = [[57.022, 22.535], [55.669, 23.888], [53.756, 23.888], [52.403, 22.535], [52.403, 20.621], [53.756, 19.268], [55.669, 19.268], [57.022, 20.621]];  // bolt window 6, 8 points

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
