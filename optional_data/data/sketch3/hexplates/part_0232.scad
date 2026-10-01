$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 6-gon R25, 4 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 6;                // number of polygon sides
plate_r = 25;             // circumscribed radius of the polygon
bore_r = 6;               // centre bore radius
bolts = 4;                // number of bolt windows
ring_r = 16.45;           // bolt-circle radius
bolt_r = 4;               // bolt window radius
plate_t = 6;              // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[50, 21.651], [37.5, 43.301], [12.5, 43.301], [0, 21.651], [12.5, 0], [37.5, 0]];  // primary outline, 6 points, counter clockwise
void_1 = [[30.543, 23.947], [27.296, 27.194], [22.704, 27.194], [19.457, 23.947], [19.457, 19.355], [22.704, 16.108], [27.296, 16.108], [30.543, 19.355]];  // centre bore, 8 points
void_2 = [[45.146, 23.182], [42.981, 25.347], [39.919, 25.347], [37.754, 23.182], [37.754, 20.12], [39.919, 17.955], [42.981, 17.955], [45.146, 20.12]];  // bolt window 1, 8 points
void_3 = [[28.696, 39.632], [26.531, 41.797], [23.469, 41.797], [21.304, 39.632], [21.304, 36.57], [23.469, 34.405], [26.531, 34.405], [28.696, 36.57]];  // bolt window 2, 8 points
void_4 = [[12.246, 23.182], [10.081, 25.347], [7.019, 25.347], [4.854, 23.182], [4.854, 20.12], [7.019, 17.955], [10.081, 17.955], [12.246, 20.12]];  // bolt window 3, 8 points
void_5 = [[28.696, 6.732], [26.531, 8.897], [23.469, 8.897], [21.304, 6.732], [21.304, 3.67], [23.469, 1.505], [26.531, 1.505], [28.696, 3.67]];  // bolt window 4, 8 points

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
