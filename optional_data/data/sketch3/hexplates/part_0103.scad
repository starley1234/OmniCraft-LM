$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 8-gon R30, 6 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 8;                // number of polygon sides
plate_r = 30;             // circumscribed radius of the polygon
bore_r = 6;               // centre bore radius
bolts = 6;                // number of bolt windows
ring_r = 16.86;           // bolt-circle radius
bolt_r = 3;               // bolt window radius
plate_t = 10;             // plate thickness, Z (extrusion height)
fit_tol = 0.1;            // declared fit tolerance (prompt contract)
free_tol = 0.3;           // declared free tolerance (prompt contract)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[60, 30], [51.213, 51.213], [30, 60], [8.787, 51.213], [0, 30], [8.787, 8.787], [30, 0], [51.213, 8.787]];  // primary outline, 8 points, counter clockwise
void_1 = [[35.543, 32.296], [32.296, 35.543], [27.704, 35.543], [24.457, 32.296], [24.457, 27.704], [27.704, 24.457], [32.296, 24.457], [35.543, 27.704]];  // centre bore, 8 points
void_2 = [[49.632, 31.148], [48.008, 32.772], [45.712, 32.772], [44.088, 31.148], [44.088, 28.852], [45.712, 27.228], [48.008, 27.228], [49.632, 28.852]];  // bolt window 1, 8 points
void_3 = [[41.202, 45.749], [39.578, 47.373], [37.282, 47.373], [35.658, 45.749], [35.658, 43.453], [37.282, 41.83], [39.578, 41.83], [41.202, 43.453]];  // bolt window 2, 8 points
void_4 = [[24.342, 45.749], [22.718, 47.373], [20.422, 47.373], [18.798, 45.749], [18.798, 43.453], [20.422, 41.83], [22.718, 41.83], [24.342, 43.453]];  // bolt window 3, 8 points
void_5 = [[15.912, 31.148], [14.288, 32.772], [11.992, 32.772], [10.368, 31.148], [10.368, 28.852], [11.992, 27.228], [14.288, 27.228], [15.912, 28.852]];  // bolt window 4, 8 points
void_6 = [[24.342, 16.547], [22.718, 18.17], [20.422, 18.17], [18.798, 16.547], [18.798, 14.251], [20.422, 12.627], [22.718, 12.627], [24.342, 14.251]];  // bolt window 5, 8 points
void_7 = [[41.202, 16.547], [39.578, 18.17], [37.282, 18.17], [35.658, 16.547], [35.658, 14.251], [37.282, 12.627], [39.578, 12.627], [41.202, 14.251]];  // bolt window 6, 8 points

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
