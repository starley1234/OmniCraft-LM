$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 6-gon R30, 4 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 6;                // number of polygon sides
plate_r = 30;             // circumscribed radius of the polygon
bore_r = 10;              // centre bore radius
bolts = 4;                // number of bolt windows
ring_r = 21.78;           // bolt-circle radius
bolt_r = 3;               // bolt window radius
plate_t = 10;             // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[57.956, 36.742], [36.742, 57.956], [7.765, 50.191], [0, 21.213], [21.213, 0], [50.191, 7.765]];  // primary outline, 6 points, counter clockwise
void_1 = [[38.217, 32.805], [32.805, 38.217], [25.151, 38.217], [19.739, 32.805], [19.739, 25.151], [25.151, 19.739], [32.805, 19.739], [38.217, 25.151]];  // centre bore, 8 points
void_2 = [[52.788, 35.763], [51.164, 37.387], [48.868, 37.387], [47.244, 35.763], [47.244, 33.467], [48.868, 31.843], [51.164, 31.843], [52.788, 33.467]];  // bolt window 1, 8 points
void_3 = [[26.113, 51.164], [24.489, 52.788], [22.193, 52.788], [20.569, 51.164], [20.569, 48.868], [22.193, 47.244], [24.489, 47.244], [26.113, 48.868]];  // bolt window 2, 8 points
void_4 = [[10.712, 24.489], [9.088, 26.113], [6.792, 26.113], [5.168, 24.489], [5.168, 22.193], [6.792, 20.569], [9.088, 20.569], [10.712, 22.193]];  // bolt window 3, 8 points
void_5 = [[37.387, 9.088], [35.763, 10.712], [33.467, 10.712], [31.843, 9.088], [31.843, 6.792], [33.467, 5.168], [35.763, 5.168], [37.387, 6.792]];  // bolt window 4, 8 points

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
