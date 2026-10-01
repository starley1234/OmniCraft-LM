$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 8-gon R25, 6 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 8;                // number of polygon sides
plate_r = 25;             // circumscribed radius of the polygon
bore_r = 8;               // centre bore radius
bolts = 6;                // number of bolt windows
ring_r = 15.55;           // bolt-circle radius
bolt_r = 2.5;             // bolt window radius
plate_t = 8;              // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[50, 25], [42.678, 42.678], [25, 50], [7.322, 42.678], [0, 25], [7.322, 7.322], [25, 0], [42.678, 7.322]];  // primary outline, 8 points, counter clockwise
void_1 = [[32.391, 28.061], [28.061, 32.391], [21.939, 32.391], [17.609, 28.061], [17.609, 21.939], [21.939, 17.609], [28.061, 17.609], [32.391, 21.939]];  // centre bore, 8 points
void_2 = [[42.86, 25.957], [41.507, 27.31], [39.593, 27.31], [38.24, 25.957], [38.24, 24.043], [39.593, 22.69], [41.507, 22.69], [42.86, 24.043]];  // bolt window 1, 8 points
void_3 = [[35.085, 39.423], [33.732, 40.776], [31.818, 40.776], [30.465, 39.423], [30.465, 37.51], [31.818, 36.157], [33.732, 36.157], [35.085, 37.51]];  // bolt window 2, 8 points
void_4 = [[19.535, 39.423], [18.182, 40.776], [16.268, 40.776], [14.915, 39.423], [14.915, 37.51], [16.268, 36.157], [18.182, 36.157], [19.535, 37.51]];  // bolt window 3, 8 points
void_5 = [[11.76, 25.957], [10.407, 27.31], [8.493, 27.31], [7.14, 25.957], [7.14, 24.043], [8.493, 22.69], [10.407, 22.69], [11.76, 24.043]];  // bolt window 4, 8 points
void_6 = [[19.535, 12.49], [18.182, 13.843], [16.268, 13.843], [14.915, 12.49], [14.915, 10.577], [16.268, 9.224], [18.182, 9.224], [19.535, 10.577]];  // bolt window 5, 8 points
void_7 = [[35.085, 12.49], [33.732, 13.843], [31.818, 13.843], [30.465, 12.49], [30.465, 10.577], [31.818, 9.224], [33.732, 9.224], [35.085, 10.577]];  // bolt window 6, 8 points

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
