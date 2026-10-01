$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 8-gon R25, 6 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 8;                // number of polygon sides
plate_r = 25;             // circumscribed radius of the polygon
bore_r = 10;              // centre bore radius
bolts = 6;                // number of bolt windows
ring_r = 16.55;           // bolt-circle radius
bolt_r = 2.5;             // bolt window radius
plate_t = 10;             // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[49.039, 29.397], [38.409, 45.306], [19.642, 49.039], [3.733, 38.409], [0, 19.642], [10.63, 3.733], [29.397, 0], [45.306, 10.63]];  // primary outline, 8 points, counter clockwise
void_1 = [[33.759, 28.347], [28.347, 33.759], [20.693, 33.759], [15.281, 28.347], [15.281, 20.693], [20.693, 15.281], [28.347, 15.281], [33.759, 20.693]];  // centre bore, 8 points
void_2 = [[43.062, 28.705], [41.709, 30.058], [39.795, 30.058], [38.442, 28.705], [38.442, 26.792], [39.795, 25.439], [41.709, 25.439], [43.062, 26.792]];  // bolt window 1, 8 points
void_3 = [[32.15, 41.148], [30.797, 42.501], [28.883, 42.501], [27.53, 41.148], [27.53, 39.235], [28.883, 37.882], [30.797, 37.882], [32.15, 39.235]];  // bolt window 2, 8 points
void_4 = [[15.918, 37.92], [14.565, 39.273], [12.651, 39.273], [11.298, 37.92], [11.298, 36.006], [12.651, 34.653], [14.565, 34.653], [15.918, 36.006]];  // bolt window 3, 8 points
void_5 = [[10.598, 22.248], [9.245, 23.601], [7.331, 23.601], [5.978, 22.248], [5.978, 20.335], [7.331, 18.982], [9.245, 18.982], [10.598, 20.335]];  // bolt window 4, 8 points
void_6 = [[21.51, 9.805], [20.157, 11.158], [18.243, 11.158], [16.89, 9.805], [16.89, 7.892], [18.243, 6.539], [20.157, 6.539], [21.51, 7.892]];  // bolt window 5, 8 points
void_7 = [[37.742, 13.034], [36.389, 14.387], [34.475, 14.387], [33.122, 13.034], [33.122, 11.12], [34.475, 9.767], [36.389, 9.767], [37.742, 11.12]];  // bolt window 6, 8 points

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
