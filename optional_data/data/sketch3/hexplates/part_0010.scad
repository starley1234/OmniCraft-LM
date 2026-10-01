$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 8-gon R35, 3 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 8;                // number of polygon sides
plate_r = 35;             // circumscribed radius of the polygon
bore_r = 8;               // centre bore radius
bolts = 3;                // number of bolt windows
ring_r = 20.17;           // bolt-circle radius
bolt_r = 2.5;             // bolt window radius
plate_t = 10;             // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[68.655, 41.156], [53.772, 63.429], [27.499, 68.655], [5.226, 53.772], [0, 27.499], [14.883, 5.226], [41.156, 0], [63.429, 14.883]];  // primary outline, 8 points, counter clockwise
void_1 = [[41.718, 37.388], [37.388, 41.718], [31.266, 41.718], [26.936, 37.388], [26.936, 31.266], [31.266, 26.936], [37.388, 26.936], [41.718, 31.266]];  // centre bore, 8 points
void_2 = [[56.419, 39.219], [55.066, 40.572], [53.153, 40.572], [51.8, 39.219], [51.8, 37.305], [53.153, 35.952], [55.066, 35.952], [56.419, 37.305]];  // bolt window 1, 8 points
void_3 = [[23.338, 50.448], [21.985, 51.801], [20.071, 51.801], [18.718, 50.448], [18.718, 48.535], [20.071, 47.182], [21.985, 47.182], [23.338, 48.535]];  // bolt window 2, 8 points
void_4 = [[30.153, 16.184], [28.8, 17.537], [26.887, 17.537], [25.534, 16.184], [25.534, 14.271], [26.887, 12.918], [28.8, 12.918], [30.153, 14.271]];  // bolt window 3, 8 points

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
