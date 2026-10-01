$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 8-gon R35, 4 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 8;                // number of polygon sides
plate_r = 35;             // circumscribed radius of the polygon
bore_r = 6;               // centre bore radius
bolts = 4;                // number of bolt windows
ring_r = 19.17;           // bolt-circle radius
bolt_r = 4;               // bolt window radius
plate_t = 8;              // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[68.655, 41.156], [53.772, 63.429], [27.499, 68.655], [5.226, 53.772], [0, 27.499], [14.883, 5.226], [41.156, 0], [63.429, 14.883]];  // primary outline, 8 points, counter clockwise
void_1 = [[39.87, 36.623], [36.623, 39.87], [32.031, 39.87], [28.784, 36.623], [28.784, 32.031], [32.031, 28.784], [36.623, 28.784], [39.87, 32.031]];  // centre bore, 8 points
void_2 = [[56.824, 39.598], [54.659, 41.762], [51.598, 41.762], [49.433, 39.598], [49.433, 36.536], [51.598, 34.371], [54.659, 34.371], [56.824, 36.536]];  // bolt window 1, 8 points
void_3 = [[34.283, 54.659], [32.118, 56.824], [29.056, 56.824], [26.892, 54.659], [26.892, 51.598], [29.056, 49.433], [32.118, 49.433], [34.283, 51.598]];  // bolt window 2, 8 points
void_4 = [[19.221, 32.118], [17.056, 34.283], [13.995, 34.283], [11.83, 32.118], [11.83, 29.056], [13.995, 26.892], [17.056, 26.892], [19.221, 29.056]];  // bolt window 3, 8 points
void_5 = [[41.762, 17.056], [39.598, 19.221], [36.536, 19.221], [34.371, 17.056], [34.371, 13.995], [36.536, 11.83], [39.598, 11.83], [41.762, 13.995]];  // bolt window 4, 8 points

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
