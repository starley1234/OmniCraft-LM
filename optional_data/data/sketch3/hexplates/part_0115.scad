$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 6-gon R40, 6 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 6;                // number of polygon sides
plate_r = 40;             // circumscribed radius of the polygon
bore_r = 8;               // centre bore radius
bolts = 6;                // number of bolt windows
ring_r = 30.44;           // bolt-circle radius
bolt_r = 3;               // bolt window radius
plate_t = 5;              // plate thickness, Z (extrusion height)
fit_tol = 0.1;            // declared fit tolerance (prompt contract)
free_tol = 0.5;           // declared free tolerance (prompt contract)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[80, 34.641], [60, 69.282], [20, 69.282], [0, 34.641], [20, 0], [60, 0]];  // primary outline, 6 points, counter clockwise
void_1 = [[47.391, 37.702], [43.061, 42.032], [36.939, 42.032], [32.609, 37.702], [32.609, 31.58], [36.939, 27.25], [43.061, 27.25], [47.391, 31.58]];  // centre bore, 8 points
void_2 = [[73.212, 35.789], [71.588, 37.413], [69.292, 37.413], [67.668, 35.789], [67.668, 33.493], [69.292, 31.869], [71.588, 31.869], [73.212, 33.493]];  // bolt window 1, 8 points
void_3 = [[57.992, 62.151], [56.368, 63.774], [54.072, 63.774], [52.448, 62.151], [52.448, 59.855], [54.072, 58.231], [56.368, 58.231], [57.992, 59.855]];  // bolt window 2, 8 points
void_4 = [[27.552, 62.151], [25.928, 63.774], [23.632, 63.774], [22.008, 62.151], [22.008, 59.855], [23.632, 58.231], [25.928, 58.231], [27.552, 59.855]];  // bolt window 3, 8 points
void_5 = [[12.332, 35.789], [10.708, 37.413], [8.412, 37.413], [6.788, 35.789], [6.788, 33.493], [8.412, 31.869], [10.708, 31.869], [12.332, 33.493]];  // bolt window 4, 8 points
void_6 = [[27.552, 9.427], [25.928, 11.051], [23.632, 11.051], [22.008, 9.427], [22.008, 7.131], [23.632, 5.508], [25.928, 5.508], [27.552, 7.131]];  // bolt window 5, 8 points
void_7 = [[57.992, 9.427], [56.368, 11.051], [54.072, 11.051], [52.448, 9.427], [52.448, 7.131], [54.072, 5.508], [56.368, 5.508], [57.992, 7.131]];  // bolt window 6, 8 points

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
