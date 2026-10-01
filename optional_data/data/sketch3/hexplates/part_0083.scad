$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 8-gon R40, 6 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 8;                // number of polygon sides
plate_r = 40;             // circumscribed radius of the polygon
bore_r = 8;               // centre bore radius
bolts = 6;                // number of bolt windows
ring_r = 22.48;           // bolt-circle radius
bolt_r = 2.5;             // bolt window radius
plate_t = 8;              // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[78.463, 47.035], [61.454, 72.49], [31.428, 78.463], [5.973, 61.454], [0, 31.428], [17.009, 5.973], [47.035, 0], [72.49, 17.009]];  // primary outline, 8 points, counter clockwise
void_1 = [[46.622, 42.292], [42.292, 46.622], [36.17, 46.622], [31.84, 42.292], [31.84, 36.17], [36.17, 31.84], [42.292, 31.84], [46.622, 36.17]];  // centre bore, 8 points
void_2 = [[63.589, 44.573], [62.236, 45.926], [60.322, 45.926], [58.969, 44.573], [58.969, 42.66], [60.322, 41.307], [62.236, 41.307], [63.589, 42.66]];  // bolt window 1, 8 points
void_3 = [[48.767, 61.475], [47.414, 62.828], [45.5, 62.828], [44.147, 61.475], [44.147, 59.561], [45.5, 58.208], [47.414, 58.208], [48.767, 59.561]];  // bolt window 2, 8 points
void_4 = [[26.719, 57.089], [25.366, 58.442], [23.452, 58.442], [22.099, 57.089], [22.099, 55.176], [23.452, 53.823], [25.366, 53.823], [26.719, 55.176]];  // bolt window 3, 8 points
void_5 = [[19.493, 35.802], [18.14, 37.155], [16.226, 37.155], [14.873, 35.802], [14.873, 33.889], [16.226, 32.536], [18.14, 32.536], [19.493, 33.889]];  // bolt window 4, 8 points
void_6 = [[34.315, 18.901], [32.962, 20.254], [31.048, 20.254], [29.695, 18.901], [29.695, 16.987], [31.048, 15.634], [32.962, 15.634], [34.315, 16.987]];  // bolt window 5, 8 points
void_7 = [[56.363, 23.286], [55.01, 24.639], [53.096, 24.639], [51.743, 23.286], [51.743, 21.373], [53.096, 20.02], [55.01, 20.02], [56.363, 21.373]];  // bolt window 6, 8 points

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
