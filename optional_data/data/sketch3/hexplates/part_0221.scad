$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 8-gon R40, 6 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 8;                // number of polygon sides
plate_r = 40;             // circumscribed radius of the polygon
bore_r = 10;              // centre bore radius
bolts = 6;                // number of bolt windows
ring_r = 23.48;           // bolt-circle radius
bolt_r = 4;               // bolt window radius
plate_t = 8;              // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[78.463, 47.035], [61.454, 72.49], [31.428, 78.463], [5.973, 61.454], [0, 31.428], [17.009, 5.973], [47.035, 0], [72.49, 17.009]];  // primary outline, 8 points, counter clockwise
void_1 = [[48.47, 43.058], [43.058, 48.47], [35.404, 48.47], [29.992, 43.058], [29.992, 35.404], [35.404, 29.992], [43.058, 29.992], [48.47, 35.404]];  // centre bore, 8 points
void_2 = [[65.955, 45.342], [63.791, 47.507], [60.729, 47.507], [58.564, 45.342], [58.564, 42.281], [60.729, 40.116], [63.791, 40.116], [65.955, 42.281]];  // bolt window 1, 8 points
void_3 = [[50.474, 62.996], [48.309, 65.16], [45.248, 65.16], [43.083, 62.996], [43.083, 59.934], [45.248, 57.769], [48.309, 57.769], [50.474, 59.934]];  // bolt window 2, 8 points
void_4 = [[27.445, 58.415], [25.28, 60.58], [22.219, 60.58], [20.054, 58.415], [20.054, 55.353], [22.219, 53.189], [25.28, 53.189], [27.445, 55.353]];  // bolt window 3, 8 points
void_5 = [[19.898, 36.181], [17.733, 38.346], [14.671, 38.346], [12.507, 36.181], [12.507, 33.12], [14.671, 30.955], [17.733, 30.955], [19.898, 33.12]];  // bolt window 4, 8 points
void_6 = [[35.379, 18.528], [33.214, 20.693], [30.153, 20.693], [27.988, 18.528], [27.988, 15.466], [30.153, 13.302], [33.214, 13.302], [35.379, 15.466]];  // bolt window 5, 8 points
void_7 = [[58.408, 23.109], [56.243, 25.273], [53.182, 25.273], [51.017, 23.109], [51.017, 20.047], [53.182, 17.882], [56.243, 17.882], [58.408, 20.047]];  // bolt window 6, 8 points

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
