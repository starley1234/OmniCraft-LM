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
bolt_r = 3;               // bolt window radius
plate_t = 5;              // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[78.463, 47.035], [61.454, 72.49], [31.428, 78.463], [5.973, 61.454], [0, 31.428], [17.009, 5.973], [47.035, 0], [72.49, 17.009]];  // primary outline, 8 points, counter clockwise
void_1 = [[44.774, 41.527], [41.527, 44.774], [36.935, 44.774], [33.688, 41.527], [33.688, 36.935], [36.935, 33.688], [41.527, 33.688], [44.774, 36.935]];  // centre bore, 8 points
void_2 = [[63.07, 44.57], [61.446, 46.193], [59.15, 46.193], [57.527, 44.57], [57.527, 42.273], [59.15, 40.65], [61.446, 40.65], [63.07, 42.273]];  // bolt window 1, 8 points
void_3 = [[37.812, 61.446], [36.189, 63.07], [33.892, 63.07], [32.269, 61.446], [32.269, 59.15], [33.892, 57.527], [36.189, 57.527], [37.812, 59.15]];  // bolt window 2, 8 points
void_4 = [[20.935, 36.189], [19.312, 37.812], [17.016, 37.812], [15.392, 36.189], [15.392, 33.892], [17.016, 32.269], [19.312, 32.269], [20.935, 33.892]];  // bolt window 3, 8 points
void_5 = [[46.193, 19.312], [44.57, 20.935], [42.273, 20.935], [40.65, 19.312], [40.65, 17.016], [42.273, 15.392], [44.57, 15.392], [46.193, 17.016]];  // bolt window 4, 8 points

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
