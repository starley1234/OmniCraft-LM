$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 8-gon R40, 4 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 8;                // number of polygon sides
plate_r = 40;             // circumscribed radius of the polygon
bore_r = 6;               // centre bore radius
bolts = 4;                // number of bolt windows
ring_r = 21.48;           // bolt-circle radius
bolt_r = 3;               // bolt window radius
plate_t = 8;              // plate thickness, Z (extrusion height)
fit_tol = 0.05;           // declared fit tolerance (prompt contract)
free_tol = 0.3;           // declared free tolerance (prompt contract)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[80, 40], [68.284, 68.284], [40, 80], [11.716, 68.284], [0, 40], [11.716, 11.716], [40, 0], [68.284, 11.716]];  // primary outline, 8 points, counter clockwise
void_1 = [[45.543, 42.296], [42.296, 45.543], [37.704, 45.543], [34.457, 42.296], [34.457, 37.704], [37.704, 34.457], [42.296, 34.457], [45.543, 37.704]];  // centre bore, 8 points
void_2 = [[64.252, 41.148], [62.628, 42.772], [60.332, 42.772], [58.708, 41.148], [58.708, 38.852], [60.332, 37.228], [62.628, 37.228], [64.252, 38.852]];  // bolt window 1, 8 points
void_3 = [[42.772, 62.628], [41.148, 64.252], [38.852, 64.252], [37.228, 62.628], [37.228, 60.332], [38.852, 58.708], [41.148, 58.708], [42.772, 60.332]];  // bolt window 2, 8 points
void_4 = [[21.292, 41.148], [19.668, 42.772], [17.372, 42.772], [15.748, 41.148], [15.748, 38.852], [17.372, 37.228], [19.668, 37.228], [21.292, 38.852]];  // bolt window 3, 8 points
void_5 = [[42.772, 19.668], [41.148, 21.292], [38.852, 21.292], [37.228, 19.668], [37.228, 17.372], [38.852, 15.748], [41.148, 15.748], [42.772, 17.372]];  // bolt window 4, 8 points

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
