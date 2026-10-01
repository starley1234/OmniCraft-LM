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
bolt_r = 2.5;             // bolt window radius
plate_t = 6;              // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[68.655, 41.156], [53.772, 63.429], [27.499, 68.655], [5.226, 53.772], [0, 27.499], [14.883, 5.226], [41.156, 0], [63.429, 14.883]];  // primary outline, 8 points, counter clockwise
void_1 = [[43.566, 38.154], [38.154, 43.566], [30.5, 43.566], [25.088, 38.154], [25.088, 30.5], [30.5, 25.088], [38.154, 25.088], [43.566, 30.5]];  // centre bore, 8 points
void_2 = [[57.4, 39.414], [56.047, 40.767], [54.134, 40.767], [52.781, 39.414], [52.781, 37.5], [54.134, 36.147], [56.047, 36.147], [57.4, 37.5]];  // bolt window 1, 8 points
void_3 = [[43.442, 55.33], [42.089, 56.683], [40.175, 56.683], [38.822, 55.33], [38.822, 53.417], [40.175, 52.064], [42.089, 52.064], [43.442, 53.417]];  // bolt window 2, 8 points
void_4 = [[22.678, 51.2], [21.325, 52.553], [19.412, 52.553], [18.059, 51.2], [18.059, 49.287], [19.412, 47.934], [21.325, 47.934], [22.678, 49.287]];  // bolt window 3, 8 points
void_5 = [[15.873, 31.154], [14.52, 32.507], [12.607, 32.507], [11.254, 31.154], [11.254, 29.24], [12.607, 27.887], [14.52, 27.887], [15.873, 29.24]];  // bolt window 4, 8 points
void_6 = [[29.832, 15.237], [28.479, 16.59], [26.565, 16.59], [25.212, 15.237], [25.212, 13.324], [26.565, 11.971], [28.479, 11.971], [29.832, 13.324]];  // bolt window 5, 8 points
void_7 = [[50.595, 19.367], [49.242, 20.72], [47.329, 20.72], [45.976, 19.367], [45.976, 17.454], [47.329, 16.101], [49.242, 16.101], [50.595, 17.454]];  // bolt window 6, 8 points

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
