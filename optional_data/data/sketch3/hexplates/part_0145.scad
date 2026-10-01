$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 6-gon R25, 3 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 6;                // number of polygon sides
plate_r = 25;             // circumscribed radius of the polygon
bore_r = 6;               // centre bore radius
bolts = 3;                // number of bolt windows
ring_r = 16.45;           // bolt-circle radius
bolt_r = 4;               // bolt window radius
plate_t = 5;              // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[50, 21.651], [37.5, 43.301], [12.5, 43.301], [0, 21.651], [12.5, 0], [37.5, 0]];  // primary outline, 6 points, counter clockwise
void_1 = [[30.543, 23.947], [27.296, 27.194], [22.704, 27.194], [19.457, 23.947], [19.457, 19.355], [22.704, 16.108], [27.296, 16.108], [30.543, 19.355]];  // centre bore, 8 points
void_2 = [[45.146, 23.182], [42.981, 25.347], [39.919, 25.347], [37.754, 23.182], [37.754, 20.12], [39.919, 17.955], [42.981, 17.955], [45.146, 20.12]];  // bolt window 1, 8 points
void_3 = [[20.471, 37.428], [18.306, 39.593], [15.244, 39.593], [13.079, 37.428], [13.079, 34.366], [15.244, 32.202], [18.306, 32.202], [20.471, 34.366]];  // bolt window 2, 8 points
void_4 = [[20.471, 8.936], [18.306, 11.1], [15.244, 11.1], [13.079, 8.936], [13.079, 5.874], [15.244, 3.709], [18.306, 3.709], [20.471, 5.874]];  // bolt window 3, 8 points

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
