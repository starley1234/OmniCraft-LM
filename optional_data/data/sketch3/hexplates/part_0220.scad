$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 8-gon R30, 4 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 8;                // number of polygon sides
plate_r = 30;             // circumscribed radius of the polygon
bore_r = 10;              // centre bore radius
bolts = 4;                // number of bolt windows
ring_r = 18.86;           // bolt-circle radius
bolt_r = 4;               // bolt window radius
plate_t = 10;             // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[58.847, 35.276], [46.091, 54.368], [23.571, 58.847], [4.479, 46.091], [0, 23.571], [12.756, 4.479], [35.276, 0], [54.368, 12.756]];  // primary outline, 8 points, counter clockwise
void_1 = [[38.663, 33.251], [33.251, 38.663], [25.597, 38.663], [20.185, 33.251], [20.185, 25.597], [25.597, 20.185], [33.251, 20.185], [38.663, 25.597]];  // centre bore, 8 points
void_2 = [[51.617, 34.634], [49.452, 36.799], [46.391, 36.799], [44.226, 34.634], [44.226, 31.573], [46.391, 29.408], [49.452, 29.408], [51.617, 31.573]];  // bolt window 1, 8 points
void_3 = [[29.44, 49.452], [27.275, 51.617], [24.214, 51.617], [22.049, 49.452], [22.049, 46.391], [24.214, 44.226], [27.275, 44.226], [29.44, 46.391]];  // bolt window 2, 8 points
void_4 = [[14.622, 27.275], [12.457, 29.44], [9.396, 29.44], [7.231, 27.275], [7.231, 24.214], [9.396, 22.049], [12.457, 22.049], [14.622, 24.214]];  // bolt window 3, 8 points
void_5 = [[36.799, 12.457], [34.634, 14.622], [31.573, 14.622], [29.408, 12.457], [29.408, 9.396], [31.573, 7.231], [34.634, 7.231], [36.799, 9.396]];  // bolt window 4, 8 points

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
