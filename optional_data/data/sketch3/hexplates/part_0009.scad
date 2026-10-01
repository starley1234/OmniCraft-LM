$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 6-gon R40, 4 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 6;                // number of polygon sides
plate_r = 40;             // circumscribed radius of the polygon
bore_r = 10;              // centre bore radius
bolts = 4;                // number of bolt windows
ring_r = 30.44;           // bolt-circle radius
bolt_r = 3;               // bolt window radius
plate_t = 10;             // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[80, 34.641], [60, 69.282], [20, 69.282], [0, 34.641], [20, 0], [60, 0]];  // primary outline, 6 points, counter clockwise
void_1 = [[49.239, 38.468], [43.827, 43.88], [36.173, 43.88], [30.761, 38.468], [30.761, 30.814], [36.173, 25.402], [43.827, 25.402], [49.239, 30.814]];  // centre bore, 8 points
void_2 = [[73.212, 35.789], [71.588, 37.413], [69.292, 37.413], [67.668, 35.789], [67.668, 33.493], [69.292, 31.869], [71.588, 31.869], [73.212, 33.493]];  // bolt window 1, 8 points
void_3 = [[42.772, 66.229], [41.148, 67.853], [38.852, 67.853], [37.228, 66.229], [37.228, 63.933], [38.852, 62.309], [41.148, 62.309], [42.772, 63.933]];  // bolt window 2, 8 points
void_4 = [[12.332, 35.789], [10.708, 37.413], [8.412, 37.413], [6.788, 35.789], [6.788, 33.493], [8.412, 31.869], [10.708, 31.869], [12.332, 33.493]];  // bolt window 3, 8 points
void_5 = [[42.772, 5.349], [41.148, 6.973], [38.852, 6.973], [37.228, 5.349], [37.228, 3.053], [38.852, 1.429], [41.148, 1.429], [42.772, 3.053]];  // bolt window 4, 8 points

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
