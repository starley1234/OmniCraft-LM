$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 6-gon R40, 6 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 6;                // number of polygon sides
plate_r = 40;             // circumscribed radius of the polygon
bore_r = 8;               // centre bore radius
bolts = 6;                // number of bolt windows
ring_r = 30.44;           // bolt-circle radius
bolt_r = 3;               // bolt window radius
plate_t = 5;              // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[77.274, 48.99], [48.99, 77.274], [10.353, 66.921], [0, 28.284], [28.284, 0], [66.921, 10.353]];  // primary outline, 6 points, counter clockwise
void_1 = [[46.028, 41.698], [41.698, 46.028], [35.576, 46.028], [31.246, 41.698], [31.246, 35.576], [35.576, 31.246], [41.698, 31.246], [46.028, 35.576]];  // centre bore, 8 points
void_2 = [[70.811, 47.664], [69.188, 49.287], [66.892, 49.287], [65.268, 47.664], [65.268, 45.367], [66.892, 43.744], [69.188, 43.744], [70.811, 45.367]];  // bolt window 1, 8 points
void_3 = [[49.287, 69.188], [47.664, 70.811], [45.367, 70.811], [43.744, 69.188], [43.744, 66.892], [45.367, 65.268], [47.664, 65.268], [49.287, 66.892]];  // bolt window 2, 8 points
void_4 = [[19.884, 61.309], [18.261, 62.933], [15.965, 62.933], [14.341, 61.309], [14.341, 59.013], [15.965, 57.39], [18.261, 57.39], [19.884, 59.013]];  // bolt window 3, 8 points
void_5 = [[12.006, 31.907], [10.382, 33.53], [8.086, 33.53], [6.463, 31.907], [6.463, 29.61], [8.086, 27.987], [10.382, 27.987], [12.006, 29.61]];  // bolt window 4, 8 points
void_6 = [[33.53, 10.382], [31.907, 12.006], [29.61, 12.006], [27.987, 10.382], [27.987, 8.086], [29.61, 6.463], [31.907, 6.463], [33.53, 8.086]];  // bolt window 5, 8 points
void_7 = [[62.933, 18.261], [61.309, 19.884], [59.013, 19.884], [57.39, 18.261], [57.39, 15.965], [59.013, 14.341], [61.309, 14.341], [62.933, 15.965]];  // bolt window 6, 8 points

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
