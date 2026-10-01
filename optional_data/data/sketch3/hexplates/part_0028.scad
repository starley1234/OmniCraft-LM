$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 8-gon R35, 6 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 8;                // number of polygon sides
plate_r = 35;             // circumscribed radius of the polygon
bore_r = 10;              // centre bore radius
bolts = 6;                // number of bolt windows
ring_r = 21.17;           // bolt-circle radius
bolt_r = 3;               // bolt window radius
plate_t = 8;              // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[68.655, 41.156], [53.772, 63.429], [27.499, 68.655], [5.226, 53.772], [0, 27.499], [14.883, 5.226], [41.156, 0], [63.429, 14.883]];  // primary outline, 8 points, counter clockwise
void_1 = [[43.566, 38.154], [38.154, 43.566], [30.5, 43.566], [25.088, 38.154], [25.088, 30.5], [30.5, 25.088], [38.154, 25.088], [43.566, 30.5]];  // centre bore, 8 points
void_2 = [[57.862, 39.605], [56.238, 41.229], [53.942, 41.229], [52.319, 39.605], [52.319, 37.309], [53.942, 35.685], [56.238, 35.685], [57.862, 37.309]];  // bolt window 1, 8 points
void_3 = [[43.904, 55.522], [42.28, 57.145], [39.984, 57.145], [38.36, 55.522], [38.36, 53.225], [39.984, 51.602], [42.28, 51.602], [43.904, 53.225]];  // bolt window 2, 8 points
void_4 = [[23.14, 51.391], [21.517, 53.015], [19.221, 53.015], [17.597, 51.391], [17.597, 49.095], [19.221, 47.472], [21.517, 47.472], [23.14, 49.095]];  // bolt window 3, 8 points
void_5 = [[16.335, 31.345], [14.712, 32.969], [12.416, 32.969], [10.792, 31.345], [10.792, 29.049], [12.416, 27.425], [14.712, 27.425], [16.335, 29.049]];  // bolt window 4, 8 points
void_6 = [[30.294, 15.429], [28.67, 17.052], [26.374, 17.052], [24.75, 15.429], [24.75, 13.132], [26.374, 11.509], [28.67, 11.509], [30.294, 13.132]];  // bolt window 5, 8 points
void_7 = [[51.057, 19.559], [49.433, 21.182], [47.137, 21.182], [45.514, 19.559], [45.514, 17.263], [47.137, 15.639], [49.433, 15.639], [51.057, 17.263]];  // bolt window 6, 8 points

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
