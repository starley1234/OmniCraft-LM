$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 8-gon R40, 6 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 8;                // number of polygon sides
plate_r = 40;             // circumscribed radius of the polygon
bore_r = 6;               // centre bore radius
bolts = 6;                // number of bolt windows
ring_r = 21.48;           // bolt-circle radius
bolt_r = 4;               // bolt window radius
plate_t = 6;              // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[78.463, 47.035], [61.454, 72.49], [31.428, 78.463], [5.973, 61.454], [0, 31.428], [17.009, 5.973], [47.035, 0], [72.49, 17.009]];  // primary outline, 8 points, counter clockwise
void_1 = [[44.774, 41.527], [41.527, 44.774], [36.935, 44.774], [33.688, 41.527], [33.688, 36.935], [36.935, 33.688], [41.527, 33.688], [44.774, 36.935]];  // centre bore, 8 points
void_2 = [[63.994, 44.952], [61.829, 47.117], [58.768, 47.117], [56.603, 44.952], [56.603, 41.891], [58.768, 39.726], [61.829, 39.726], [63.994, 41.891]];  // bolt window 1, 8 points
void_3 = [[49.831, 61.102], [47.666, 63.267], [44.605, 63.267], [42.44, 61.102], [42.44, 58.04], [44.605, 55.876], [47.666, 55.876], [49.831, 58.04]];  // bolt window 2, 8 points
void_4 = [[28.764, 56.911], [26.599, 59.076], [23.538, 59.076], [21.373, 56.911], [21.373, 53.85], [23.538, 51.685], [26.599, 51.685], [28.764, 53.85]];  // bolt window 3, 8 points
void_5 = [[21.859, 36.571], [19.694, 38.736], [16.633, 38.736], [14.468, 36.571], [14.468, 33.51], [16.633, 31.345], [19.694, 31.345], [21.859, 33.51]];  // bolt window 4, 8 points
void_6 = [[36.022, 20.422], [33.857, 22.586], [30.796, 22.586], [28.631, 20.422], [28.631, 17.36], [30.796, 15.195], [33.857, 15.195], [36.022, 17.36]];  // bolt window 5, 8 points
void_7 = [[57.089, 24.612], [54.924, 26.777], [51.863, 26.777], [49.698, 24.612], [49.698, 21.551], [51.863, 19.386], [54.924, 19.386], [57.089, 21.551]];  // bolt window 6, 8 points

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
