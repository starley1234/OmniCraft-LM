$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 6-gon R25, 3 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 6;                // number of polygon sides
plate_r = 25;             // circumscribed radius of the polygon
bore_r = 6;               // centre bore radius
bolts = 3;                // number of bolt windows
ring_r = 17.45;           // bolt-circle radius
bolt_r = 3;               // bolt window radius
plate_t = 5;              // plate thickness, Z (extrusion height)
fit_tol = 0.02;           // declared fit tolerance (prompt contract)
free_tol = 0.2;           // declared free tolerance (prompt contract)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[50, 21.651], [37.5, 43.301], [12.5, 43.301], [0, 21.651], [12.5, 0], [37.5, 0]];  // primary outline, 6 points, counter clockwise
void_1 = [[30.543, 23.947], [27.296, 27.194], [22.704, 27.194], [19.457, 23.947], [19.457, 19.355], [22.704, 16.108], [27.296, 16.108], [30.543, 19.355]];  // centre bore, 8 points
void_2 = [[45.222, 22.799], [43.598, 24.423], [41.302, 24.423], [39.678, 22.799], [39.678, 20.503], [41.302, 18.879], [43.598, 18.879], [45.222, 20.503]];  // bolt window 1, 8 points
void_3 = [[19.047, 37.911], [17.423, 39.535], [15.127, 39.535], [13.503, 37.911], [13.503, 35.615], [15.127, 33.992], [17.423, 33.992], [19.047, 35.615]];  // bolt window 2, 8 points
void_4 = [[19.047, 7.687], [17.423, 9.31], [15.127, 9.31], [13.503, 7.687], [13.503, 5.391], [15.127, 3.767], [17.423, 3.767], [19.047, 5.391]];  // bolt window 3, 8 points

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
