$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 8-gon R40, 4 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 8;                // number of polygon sides
plate_r = 40;             // circumscribed radius of the polygon
bore_r = 6;               // centre bore radius
bolts = 4;                // number of bolt windows
ring_r = 21.48;           // bolt-circle radius
bolt_r = 4;               // bolt window radius
plate_t = 10;             // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[78.463, 47.035], [61.454, 72.49], [31.428, 78.463], [5.973, 61.454], [0, 31.428], [17.009, 5.973], [47.035, 0], [72.49, 17.009]];  // primary outline, 8 points, counter clockwise
void_1 = [[44.774, 41.527], [41.527, 44.774], [36.935, 44.774], [33.688, 41.527], [33.688, 36.935], [36.935, 33.688], [41.527, 33.688], [44.774, 36.935]];  // centre bore, 8 points
void_2 = [[63.994, 44.952], [61.829, 47.117], [58.768, 47.117], [56.603, 44.952], [56.603, 41.891], [58.768, 39.726], [61.829, 39.726], [63.994, 41.891]];  // bolt window 1, 8 points
void_3 = [[38.736, 61.829], [36.571, 63.994], [33.51, 63.994], [31.345, 61.829], [31.345, 58.768], [33.51, 56.603], [36.571, 56.603], [38.736, 58.768]];  // bolt window 2, 8 points
void_4 = [[21.859, 36.571], [19.694, 38.736], [16.633, 38.736], [14.468, 36.571], [14.468, 33.51], [16.633, 31.345], [19.694, 31.345], [21.859, 33.51]];  // bolt window 3, 8 points
void_5 = [[47.117, 19.694], [44.952, 21.859], [41.891, 21.859], [39.726, 19.694], [39.726, 16.633], [41.891, 14.468], [44.952, 14.468], [47.117, 16.633]];  // bolt window 4, 8 points

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
