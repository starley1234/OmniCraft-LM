$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 6-gon R25, 4 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 6;                // number of polygon sides
plate_r = 25;             // circumscribed radius of the polygon
bore_r = 6;               // centre bore radius
bolts = 4;                // number of bolt windows
ring_r = 17.95;           // bolt-circle radius
bolt_r = 2.5;             // bolt window radius
plate_t = 6;              // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[50, 21.651], [37.5, 43.301], [12.5, 43.301], [0, 21.651], [12.5, 0], [37.5, 0]];  // primary outline, 6 points, counter clockwise
void_1 = [[30.543, 23.947], [27.296, 27.194], [22.704, 27.194], [19.457, 23.947], [19.457, 19.355], [22.704, 16.108], [27.296, 16.108], [30.543, 19.355]];  // centre bore, 8 points
void_2 = [[45.26, 22.608], [43.907, 23.961], [41.993, 23.961], [40.64, 22.608], [40.64, 20.694], [41.993, 19.341], [43.907, 19.341], [45.26, 20.694]];  // bolt window 1, 8 points
void_3 = [[27.31, 40.558], [25.957, 41.911], [24.043, 41.911], [22.69, 40.558], [22.69, 38.644], [24.043, 37.291], [25.957, 37.291], [27.31, 38.644]];  // bolt window 2, 8 points
void_4 = [[9.36, 22.608], [8.007, 23.961], [6.093, 23.961], [4.74, 22.608], [4.74, 20.694], [6.093, 19.341], [8.007, 19.341], [9.36, 20.694]];  // bolt window 3, 8 points
void_5 = [[27.31, 4.658], [25.957, 6.011], [24.043, 6.011], [22.69, 4.658], [22.69, 2.744], [24.043, 1.391], [25.957, 1.391], [27.31, 2.744]];  // bolt window 4, 8 points

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
