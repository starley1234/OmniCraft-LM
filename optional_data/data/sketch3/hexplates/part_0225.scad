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
bolt_r = 4;               // bolt window radius
plate_t = 5;              // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[68.655, 41.156], [53.772, 63.429], [27.499, 68.655], [5.226, 53.772], [0, 27.499], [14.883, 5.226], [41.156, 0], [63.429, 14.883]];  // primary outline, 8 points, counter clockwise
void_1 = [[41.718, 37.388], [37.388, 41.718], [31.266, 41.718], [26.936, 37.388], [26.936, 31.266], [31.266, 26.936], [37.388, 26.936], [41.718, 31.266]];  // centre bore, 8 points
void_2 = [[57.805, 39.793], [55.64, 41.957], [52.579, 41.957], [50.414, 39.793], [50.414, 36.731], [52.579, 34.566], [55.64, 34.566], [57.805, 36.731]];  // bolt window 1, 8 points
void_3 = [[24.724, 51.022], [22.559, 53.187], [19.497, 53.187], [17.332, 51.022], [17.332, 47.961], [19.497, 45.796], [22.559, 45.796], [24.724, 47.961]];  // bolt window 2, 8 points
void_4 = [[31.539, 16.758], [29.374, 18.923], [26.313, 18.923], [24.148, 16.758], [24.148, 13.697], [26.313, 11.532], [29.374, 11.532], [31.539, 13.697]];  // bolt window 3, 8 points

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
