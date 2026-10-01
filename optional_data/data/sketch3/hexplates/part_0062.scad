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
bolt_r = 2.5;             // bolt window radius
plate_t = 5;              // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[78.463, 47.035], [61.454, 72.49], [31.428, 78.463], [5.973, 61.454], [0, 31.428], [17.009, 5.973], [47.035, 0], [72.49, 17.009]];  // primary outline, 8 points, counter clockwise
void_1 = [[44.774, 41.527], [41.527, 44.774], [36.935, 44.774], [33.688, 41.527], [33.688, 36.935], [36.935, 33.688], [41.527, 33.688], [44.774, 36.935]];  // centre bore, 8 points
void_2 = [[62.608, 44.378], [61.255, 45.731], [59.342, 45.731], [57.989, 44.378], [57.989, 42.465], [59.342, 41.112], [61.255, 41.112], [62.608, 42.465]];  // bolt window 1, 8 points
void_3 = [[48.445, 60.528], [47.092, 61.881], [45.179, 61.881], [43.826, 60.528], [43.826, 58.614], [45.179, 57.261], [47.092, 57.261], [48.445, 58.614]];  // bolt window 2, 8 points
void_4 = [[27.378, 56.337], [26.025, 57.69], [24.112, 57.69], [22.759, 56.337], [22.759, 54.424], [24.112, 53.071], [26.025, 53.071], [27.378, 54.424]];  // bolt window 3, 8 points
void_5 = [[20.473, 35.997], [19.12, 37.35], [17.207, 37.35], [15.854, 35.997], [15.854, 34.084], [17.207, 32.731], [19.12, 32.731], [20.473, 34.084]];  // bolt window 4, 8 points
void_6 = [[34.636, 19.848], [33.283, 21.201], [31.37, 21.201], [30.017, 19.848], [30.017, 17.934], [31.37, 16.581], [33.283, 16.581], [34.636, 17.934]];  // bolt window 5, 8 points
void_7 = [[55.703, 24.038], [54.35, 25.391], [52.437, 25.391], [51.084, 24.038], [51.084, 22.125], [52.437, 20.772], [54.35, 20.772], [55.703, 22.125]];  // bolt window 6, 8 points

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
