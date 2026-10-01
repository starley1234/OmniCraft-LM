$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 6-gon R25, 3 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 6;                // number of polygon sides
plate_r = 25;             // circumscribed radius of the polygon
bore_r = 10;              // centre bore radius
bolts = 3;                // number of bolt windows
ring_r = 17.95;           // bolt-circle radius
bolt_r = 2.5;             // bolt window radius
plate_t = 5;              // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[50, 21.651], [37.5, 43.301], [12.5, 43.301], [0, 21.651], [12.5, 0], [37.5, 0]];  // primary outline, 6 points, counter clockwise
void_1 = [[34.239, 25.478], [28.827, 30.89], [21.173, 30.89], [15.761, 25.478], [15.761, 17.824], [21.173, 12.412], [28.827, 12.412], [34.239, 17.824]];  // centre bore, 8 points
void_2 = [[45.26, 22.608], [43.907, 23.961], [41.993, 23.961], [40.64, 22.608], [40.64, 20.694], [41.993, 19.341], [43.907, 19.341], [45.26, 20.694]];  // bolt window 1, 8 points
void_3 = [[18.335, 38.153], [16.982, 39.506], [15.068, 39.506], [13.715, 38.153], [13.715, 36.239], [15.068, 34.886], [16.982, 34.886], [18.335, 36.239]];  // bolt window 2, 8 points
void_4 = [[18.335, 7.063], [16.982, 8.416], [15.068, 8.416], [13.715, 7.063], [13.715, 5.149], [15.068, 3.796], [16.982, 3.796], [18.335, 5.149]];  // bolt window 3, 8 points

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
