$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 8-gon R35, 6 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 8;                // number of polygon sides
plate_r = 35;             // circumscribed radius of the polygon
bore_r = 6;               // centre bore radius
bolts = 6;                // number of bolt windows
ring_r = 19.17;           // bolt-circle radius
bolt_r = 3;               // bolt window radius
plate_t = 5;              // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[68.655, 41.156], [53.772, 63.429], [27.499, 68.655], [5.226, 53.772], [0, 27.499], [14.883, 5.226], [41.156, 0], [63.429, 14.883]];  // primary outline, 8 points, counter clockwise
void_1 = [[39.87, 36.623], [36.623, 39.87], [32.031, 39.87], [28.784, 36.623], [28.784, 32.031], [32.031, 28.784], [36.623, 28.784], [39.87, 32.031]];  // centre bore, 8 points
void_2 = [[55.9, 39.215], [54.277, 40.839], [51.981, 40.839], [50.357, 39.215], [50.357, 36.919], [51.981, 35.295], [54.277, 35.295], [55.9, 36.919]];  // bolt window 1, 8 points
void_3 = [[43.261, 53.628], [41.637, 55.251], [39.341, 55.251], [37.717, 53.628], [37.717, 51.332], [39.341, 49.708], [41.637, 49.708], [43.261, 51.332]];  // bolt window 2, 8 points
void_4 = [[24.459, 49.888], [22.835, 51.511], [20.539, 51.511], [18.916, 49.888], [18.916, 47.592], [20.539, 45.968], [22.835, 45.968], [24.459, 47.592]];  // bolt window 3, 8 points
void_5 = [[18.297, 31.735], [16.673, 33.359], [14.377, 33.359], [12.754, 31.735], [12.754, 29.439], [14.377, 27.815], [16.673, 27.815], [18.297, 29.439]];  // bolt window 4, 8 points
void_6 = [[30.937, 17.322], [29.313, 18.946], [27.017, 18.946], [25.393, 17.322], [25.393, 15.026], [27.017, 13.403], [29.313, 13.403], [30.937, 15.026]];  // bolt window 5, 8 points
void_7 = [[49.738, 21.062], [48.115, 22.686], [45.819, 22.686], [44.195, 21.062], [44.195, 18.766], [45.819, 17.143], [48.115, 17.143], [49.738, 18.766]];  // bolt window 6, 8 points

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
