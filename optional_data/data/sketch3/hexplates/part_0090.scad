$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 6-gon R35, 4 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 6;                // number of polygon sides
plate_r = 35;             // circumscribed radius of the polygon
bore_r = 10;              // centre bore radius
bolts = 4;                // number of bolt windows
ring_r = 26.61;           // bolt-circle radius
bolt_r = 2.5;             // bolt window radius
plate_t = 8;              // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[67.615, 42.866], [42.866, 67.615], [9.059, 58.556], [0, 24.749], [24.749, 0], [58.556, 9.059]];  // primary outline, 6 points, counter clockwise
void_1 = [[43.046, 37.634], [37.634, 43.046], [29.98, 43.046], [24.568, 37.634], [24.568, 29.98], [29.98, 24.568], [37.634, 24.568], [43.046, 29.98]];  // centre bore, 8 points
void_2 = [[61.82, 41.651], [60.467, 43.004], [58.554, 43.004], [57.201, 41.651], [57.201, 39.737], [58.554, 38.384], [60.467, 38.384], [61.82, 39.737]];  // bolt window 1, 8 points
void_3 = [[29.23, 60.467], [27.877, 61.82], [25.963, 61.82], [24.61, 60.467], [24.61, 58.554], [25.963, 57.201], [27.877, 57.201], [29.23, 58.554]];  // bolt window 2, 8 points
void_4 = [[10.413, 27.877], [9.06, 29.23], [7.147, 29.23], [5.794, 27.877], [5.794, 25.963], [7.147, 24.61], [9.06, 24.61], [10.413, 25.963]];  // bolt window 3, 8 points
void_5 = [[43.004, 9.06], [41.651, 10.413], [39.737, 10.413], [38.384, 9.06], [38.384, 7.147], [39.737, 5.794], [41.651, 5.794], [43.004, 7.147]];  // bolt window 4, 8 points

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
