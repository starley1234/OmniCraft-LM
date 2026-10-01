$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 6-gon R35, 6 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 6;                // number of polygon sides
plate_r = 35;             // circumscribed radius of the polygon
bore_r = 8;               // centre bore radius
bolts = 6;                // number of bolt windows
ring_r = 26.61;           // bolt-circle radius
bolt_r = 2.5;             // bolt window radius
plate_t = 8;              // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[67.615, 42.866], [42.866, 67.615], [9.059, 58.556], [0, 24.749], [24.749, 0], [58.556, 9.059]];  // primary outline, 6 points, counter clockwise
void_1 = [[41.198, 36.868], [36.868, 41.198], [30.746, 41.198], [26.416, 36.868], [26.416, 30.746], [30.746, 26.416], [36.868, 26.416], [41.198, 30.746]];  // centre bore, 8 points
void_2 = [[61.82, 41.651], [60.467, 43.004], [58.554, 43.004], [57.201, 41.651], [57.201, 39.737], [58.554, 38.384], [60.467, 38.384], [61.82, 39.737]];  // bolt window 1, 8 points
void_3 = [[43.004, 60.467], [41.651, 61.82], [39.737, 61.82], [38.384, 60.467], [38.384, 58.554], [39.737, 57.201], [41.651, 57.201], [43.004, 58.554]];  // bolt window 2, 8 points
void_4 = [[17.301, 53.58], [15.948, 54.933], [14.034, 54.933], [12.681, 53.58], [12.681, 51.666], [14.034, 50.313], [15.948, 50.313], [17.301, 51.666]];  // bolt window 3, 8 points
void_5 = [[10.413, 27.877], [9.06, 29.23], [7.147, 29.23], [5.794, 27.877], [5.794, 25.963], [7.147, 24.61], [9.06, 24.61], [10.413, 25.963]];  // bolt window 4, 8 points
void_6 = [[29.23, 9.06], [27.877, 10.413], [25.963, 10.413], [24.61, 9.06], [24.61, 7.147], [25.963, 5.794], [27.877, 5.794], [29.23, 7.147]];  // bolt window 5, 8 points
void_7 = [[54.933, 15.948], [53.58, 17.301], [51.666, 17.301], [50.313, 15.948], [50.313, 14.034], [51.666, 12.681], [53.58, 12.681], [54.933, 14.034]];  // bolt window 6, 8 points

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
