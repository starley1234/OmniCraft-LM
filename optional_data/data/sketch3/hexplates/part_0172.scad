$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 6-gon R35, 6 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 6;                // number of polygon sides
plate_r = 35;             // circumscribed radius of the polygon
bore_r = 10;              // centre bore radius
bolts = 6;                // number of bolt windows
ring_r = 26.11;           // bolt-circle radius
bolt_r = 3;               // bolt window radius
plate_t = 6;              // plate thickness, Z (extrusion height)
fit_tol = 0.05;           // declared fit tolerance (prompt contract)
free_tol = 0.2;           // declared free tolerance (prompt contract)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[67.615, 42.866], [42.866, 67.615], [9.059, 58.556], [0, 24.749], [24.749, 0], [58.556, 9.059]];  // primary outline, 6 points, counter clockwise
void_1 = [[43.046, 37.634], [37.634, 43.046], [29.98, 43.046], [24.568, 37.634], [24.568, 29.98], [29.98, 24.568], [37.634, 24.568], [43.046, 29.98]];  // centre bore, 8 points
void_2 = [[61.799, 41.713], [60.175, 43.336], [57.879, 43.336], [56.256, 41.713], [56.256, 39.417], [57.879, 37.793], [60.175, 37.793], [61.799, 39.417]];  // bolt window 1, 8 points
void_3 = [[43.336, 60.175], [41.713, 61.799], [39.417, 61.799], [37.793, 60.175], [37.793, 57.879], [39.417, 56.256], [41.713, 56.256], [43.336, 57.879]];  // bolt window 2, 8 points
void_4 = [[18.116, 53.418], [16.492, 55.041], [14.196, 55.041], [12.573, 53.418], [12.573, 51.122], [14.196, 49.498], [16.492, 49.498], [18.116, 51.122]];  // bolt window 3, 8 points
void_5 = [[11.358, 28.197], [9.735, 29.821], [7.439, 29.821], [5.815, 28.197], [5.815, 25.901], [7.439, 24.278], [9.735, 24.278], [11.358, 25.901]];  // bolt window 4, 8 points
void_6 = [[29.821, 9.735], [28.197, 11.358], [25.901, 11.358], [24.278, 9.735], [24.278, 7.439], [25.901, 5.815], [28.197, 5.815], [29.821, 7.439]];  // bolt window 5, 8 points
void_7 = [[55.041, 16.492], [53.418, 18.116], [51.122, 18.116], [49.498, 16.492], [49.498, 14.196], [51.122, 12.573], [53.418, 12.573], [55.041, 14.196]];  // bolt window 6, 8 points

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
