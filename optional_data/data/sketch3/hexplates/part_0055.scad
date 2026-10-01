$fn = 32;

// ----------------------------------------------------------------------
// Polygon plate: 8-gon R40, 3 bolt windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
sides = 8;                // number of polygon sides
plate_r = 40;             // circumscribed radius of the polygon
bore_r = 6;               // centre bore radius
bolts = 3;                // number of bolt windows
ring_r = 21.48;           // bolt-circle radius
bolt_r = 3;               // bolt window radius
plate_t = 6;              // plate thickness, Z (extrusion height)

plate_d = 2 * plate_r;  // circumscribed diameter
bore_d = 2 * bore_r;  // centre bore diameter
bolt_d = 2 * bolt_r;  // bolt window diameter
ring_d = 2 * ring_r;  // bolt-circle diameter

profile = [[78.463, 47.035], [61.454, 72.49], [31.428, 78.463], [5.973, 61.454], [0, 31.428], [17.009, 5.973], [47.035, 0], [72.49, 17.009]];  // primary outline, 8 points, counter clockwise
void_1 = [[44.774, 41.527], [41.527, 44.774], [36.935, 44.774], [33.688, 41.527], [33.688, 36.935], [36.935, 33.688], [41.527, 33.688], [44.774, 36.935]];  // centre bore, 8 points
void_2 = [[63.07, 44.57], [61.446, 46.193], [59.15, 46.193], [57.527, 44.57], [57.527, 42.273], [59.15, 40.65], [61.446, 40.65], [63.07, 42.273]];  // bolt window 1, 8 points
void_3 = [[27.84, 56.529], [26.216, 58.152], [23.92, 58.152], [22.297, 56.529], [22.297, 54.232], [23.92, 52.609], [26.216, 52.609], [27.84, 54.232]];  // bolt window 2, 8 points
void_4 = [[35.098, 20.039], [33.475, 21.663], [31.178, 21.663], [29.555, 20.039], [29.555, 17.743], [31.178, 16.119], [33.475, 16.119], [35.098, 17.743]];  // bolt window 3, 8 points

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
}
