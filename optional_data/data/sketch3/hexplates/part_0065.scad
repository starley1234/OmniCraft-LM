$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 8-gon R35, 4 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 8;                // number of polygon sides
plate_r = 35;             // circumscribed radius of the polygon
bore_r = 10;              // centre bore radius
bolts = 4;                // number of bolt windows
ring_r = 21.17;           // bolt-circle radius
bolt_r = 4;               // bolt window radius
plate_t = 10;             // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[68.655, 41.156], [53.772, 63.429], [27.499, 68.655], [5.226, 53.772], [0, 27.499], [14.883, 5.226], [41.156, 0], [63.429, 14.883]];  // primary outline, 8 points, counter clockwise
void_1 = [[43.566, 38.154], [38.154, 43.566], [30.5, 43.566], [25.088, 38.154], [25.088, 30.5], [30.5, 25.088], [38.154, 25.088], [43.566, 30.5]];  // centre bore, 8 points
void_2 = [[58.786, 39.988], [56.621, 42.153], [53.559, 42.153], [51.395, 39.988], [51.395, 36.926], [53.559, 34.762], [56.621, 34.762], [58.786, 36.926]];  // bolt window 1, 8 points
void_3 = [[33.892, 56.621], [31.728, 58.786], [28.666, 58.786], [26.501, 56.621], [26.501, 53.559], [28.666, 51.395], [31.728, 51.395], [33.892, 53.559]];  // bolt window 2, 8 points
void_4 = [[17.259, 31.728], [15.095, 33.892], [12.033, 33.892], [9.868, 31.728], [9.868, 28.666], [12.033, 26.501], [15.095, 26.501], [17.259, 28.666]];  // bolt window 3, 8 points
void_5 = [[42.153, 15.095], [39.988, 17.259], [36.926, 17.259], [34.762, 15.095], [34.762, 12.033], [36.926, 9.868], [39.988, 9.868], [42.153, 12.033]];  // bolt window 4, 8 points

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
