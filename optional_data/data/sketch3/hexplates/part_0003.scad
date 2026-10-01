$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 6-gon R30, 6 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 6;                // number of polygon sides
plate_r = 30;             // circumscribed radius of the polygon
bore_r = 8;               // centre bore radius
bolts = 6;                // number of bolt windows
ring_r = 22.28;           // bolt-circle radius
bolt_r = 2.5;             // bolt window radius
plate_t = 5;              // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[60, 25.981], [45, 51.962], [15, 51.962], [0, 25.981], [15, 0], [45, 0]];  // primary outline, 6 points, counter clockwise
void_1 = [[37.391, 29.042], [33.061, 33.372], [26.939, 33.372], [22.609, 29.042], [22.609, 22.92], [26.939, 18.59], [33.061, 18.59], [37.391, 22.92]];  // centre bore, 8 points
void_2 = [[54.59, 26.938], [53.237, 28.291], [51.323, 28.291], [49.97, 26.938], [49.97, 25.024], [51.323, 23.671], [53.237, 23.671], [54.59, 25.024]];  // bolt window 1, 8 points
void_3 = [[43.45, 46.233], [42.097, 47.586], [40.183, 47.586], [38.83, 46.233], [38.83, 44.319], [40.183, 42.966], [42.097, 42.966], [43.45, 44.319]];  // bolt window 2, 8 points
void_4 = [[21.17, 46.233], [19.817, 47.586], [17.903, 47.586], [16.55, 46.233], [16.55, 44.319], [17.903, 42.966], [19.817, 42.966], [21.17, 44.319]];  // bolt window 3, 8 points
void_5 = [[10.03, 26.938], [8.677, 28.291], [6.763, 28.291], [5.41, 26.938], [5.41, 25.024], [6.763, 23.671], [8.677, 23.671], [10.03, 25.024]];  // bolt window 4, 8 points
void_6 = [[21.17, 7.643], [19.817, 8.996], [17.903, 8.996], [16.55, 7.643], [16.55, 5.729], [17.903, 4.376], [19.817, 4.376], [21.17, 5.729]];  // bolt window 5, 8 points
void_7 = [[43.45, 7.643], [42.097, 8.996], [40.183, 8.996], [38.83, 7.643], [38.83, 5.729], [40.183, 4.376], [42.097, 4.376], [43.45, 5.729]];  // bolt window 6, 8 points

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
